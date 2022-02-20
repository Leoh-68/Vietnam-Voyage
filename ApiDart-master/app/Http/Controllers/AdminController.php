<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\DiaDanh;
use App\Models\ViTri;
use App\Models\HinhAnhDiaDanh;
use App\Http\Requests\SubmitRequest;

class AdminController extends Controller
{
    public function DSDiaDanh()
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                $diadanh = DiaDanh::where('deleted_at',null)->get();
            return view('admin/DsDiaDanh',compact('diadanh'));
            }
        }
        else{
            return view('login');
        }
    }
    public static function LayViTri($id)
    {
        $vitri = ViTri::Where('id',$id)->first();
        if($vitri == null)
        {
            return "X: 0 || Y: 0";
        }
        return "X: ".sprintf("%.2f", $vitri->KinhDo)." || Y: ".sprintf("%.2f", $vitri->ViDo);
    }
    public static function LayX($id)
    {
        $vitri = ViTri::Where('id',$id)->first();
        if($vitri == null)
        {
            return "0";
        }
        return sprintf("%.2f", $vitri->KinhDo);
    }
    public static function LayY($id)
    {
        $vitri = ViTri::Where('id',$id)->first();
        if($vitri == null)
        {
            return "0";
        }
        return sprintf("%.2f", $vitri->ViDo);
    }
    public function ThemDiaDanh()
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                return view('admin/ThemDiaDanh');
            }
        }
        else{
            return view('login');
        }

    }
    public function XLThemDiaDanh(SubmitRequest $rq)
    {
        $image_name = " ";
        if ($rq->has('image')==false) {
            session()->flash('fail', 'Vui lòng chọn hình ảnh');
            return redirect()->back();
        }
        $size = $rq->image->getSize();
        $extention = $rq->image->extension();
        if ($size > 2000000) {
            session()->flash('fail', 'Kích thướt ảnh phải dưới 2M');
            return View('Teacher/Post', compact('idclass'));
        }
        if (
            $extention == "jpg" ||
            $extention == "jpeg" ||
            $extention == "gif" ||
            $extention == "tiff" ||
            $extention == "psd" ||
            $extention == "png" ||
            $extention == "jfif" ||
            $extention == "jpg"
        ) {
            $image = $rq->image;
            $image_name = $image->getClientoriginalName();
            $image->move(public_path('images'), $image_name);
        } else {
            session()->flash('fail', 'Tệp được chọn phải là hình ảnh');
            return redirect()->back();
        }
        $vtid = ViTri::where([['kinhdo',$rq->kinhdo],['vido',$rq->vido]])->first();
        if($vtid==null){
        $vt = new ViTri;
        $vt->KinhDo = $rq->kinhdo;
        $vt->ViDo = $rq->vido;
        $vt->save();
        $dd = new DiaDanh;
        $dd->TenDiaDanh = $rq->tendiadanh;
        $dd->ViTri=$rq->vungmien;
        $dd->MoTa = $rq->noidung;
        $dd->HinhAnhId=$image_name;
        $dd->ViTriId = $vt->id;
        $dd->save();
        $ddid = DiaDanh::where([['tendiadanh',$dd->TenDiaDanh],['vitriid',$dd->ViTriId],['deleted_at',null]])->first();
        $ha = new HinhAnhDiaDanh;
        $ha->diadanhid = $ddid->id;
        $ha->duongdan = "defaultimg.jpg";
        $ha->save();
        return redirect()->route('DiaDanh');
        }
        $ha = new HinhAnhDiaDanh;
        $dd = new DiaDanh;
        $dd->TenDiaDanh = $rq->tendiadanh;
        $dd->ViTriId = $vtid->id;
        $dd->MoTa = $rq->noidung;
        $dd->ViTri=$rq->vungmien;
        $dd->HinhAnhId=$image_name;
        $dd->save();
        $ddid = DiaDanh::where([['tendiadanh',$dd->tendiadanh],['vitriid',$dd->vitriid],['deleted_at',null]])->first();
        $ha->diadanhid = $ddid->id;
        $ha->duongdan = "defaultimg.jpg";
        $ha->save();
        return redirect()->route('DiaDanh');
    }
    public function SuaDiaDanh($id)
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                $dd = DiaDanh::find($id);
                if($dd==null||$dd->deleted_at!=null){
                    return view('admin/UDiaDanh');
                }
                return view('admin/SuaDiaDanh',compact('dd'));
            }
        }
        else{
            return view('login');
        }

    }
    public function XLSuaDiaDanh(SubmitRequest $rq,$id)
    {
        $vtid = ViTri::where([['kinhdo',$rq->kinhdo],['vido',$rq->vido]])->first();
        $dd = DiaDanh::find($id);
        if($vtid==null){
        $vt = new ViTri;
        $vt->KinhDo = $rq->kinhdo;
        $vt->ViDo = $rq->vido;
        $vt->save();
        $dd->TenDiaDanh = $rq->tendiadanh;
        $dd->ViTriId = $vt->id;
        $dd->NoiDung = $rq->noidung;
        $dd->updated_at = date("Y-m-d");
        $dd->save();
        return redirect()->route('DiaDanh');
        }
        $dd = DiaDanh::find($id);
        $dd->TenDiaDanh = $rq->tendiadanh;
        $dd->ViTriId = $vtid->id;
        $dd->NoiDung = $rq->noidung;
        // dd($rq->noidung);
        $dd->updated_at = date("Y-m-d");
        $dd->save();
        return redirect()->route('DiaDanh');
    }
    public function XLXoaDiaDanh($id)
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                $dd = DiaDanh::find($id);
                if($dd==null||$dd->deleted_at!=null){
                    return view('admin/UDiaDanh');
                }
                $dd->deleted_at = date("Y-m-d");
                $dd->save();
                return redirect()->route('DiaDanh');
            }
        }
        else{
            return view('login');
        }
    }
    public function DSHinhAnh($id)
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                $hinhanh = HinhAnhDiaDanh::orderBy('id')->where([['diadanhid',$id],['deleted_at',null]])->get();
                if($hinhanh->isEmpty()){
                    return view('admin/UnknowPage');
                }
                return view('admin/DSHinhAnh',compact('hinhanh'));
            }
        }
        else{
            return view('login');
        }

    }
    public function ThemHinhAnh()
    {if(session()->has('username')&&session()->has('password')){
        if(session('username') == "admin") {
            return view('admin/ThemHinhAnh');
        }
    }
    else{
        return view('login');
    }
    }
    public function XLThemHinhAnh(Request $rq,$id)
    {
        $image_name = " ";
        $maxid = (int)HinhAnhDiaDanh::max('id') + 1;
        $ha = new HinhAnhDiaDanh;
        $ha->diadanhid = $id;
        if($rq->has('image'))
        {
            $image = $rq->image;
            $image_name=$image->getClientoriginalName();
            $i = explode('.', $image_name);
            $explain =  $maxid.".".$i[1];
            $image->move(public_path('images'),$explain);
            $ha->duongdan = $explain;
            $ha->save();
            return redirect()->route('DSHinhAnh',['id' => $id]);
        }
        else{
            $ha->duongdan = "defaultimg.jpg";
            $ha->save();
            return redirect()->route('DSHinhAnh',['id' => $id]);
        }
    }
    public function SuaHinhAnh($id1,$id2)
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                $ha = HinhAnhDiaDanh::find($id2);
                return view("admin/SuaHinhAnh",compact('ha'));
            }
        }
        else{
            return view('login');
        }

    }
    public function XLSuaHinhAnh(request $rq,$id1,$id2)
    {
        $ha = HinhAnhDiaDanh::find($id2);
        if($ha==null||$ha->deleted_at!=null){
            return view('admin/UnknowPage');
        }
        if($rq->has('image'))
        {
            $image = $rq->image;
            $image_name=$image->getClientoriginalName();
            $i = explode('.', $image_name);
            $explain =  $ha->id.".".$i[1];
            $image->move(public_path('images'),$explain);
            $ha->duongdan = $explain;
            $ha->save();
            return redirect()->route('DSHinhAnh',['id' => $id1]);
        }
        return redirect()->route('DSHinhAnh',['id' => $id1]);
    }
    public function XLXoaHinhAnh($id1,$id2)
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                $ha = HinhAnhDiaDanh::find($id2);
                if($ha==null||$ha->deleted_at!=null){
                    return view('admin/UnknowPage');
                }
                $ha->deleted_at = date("Y-m-d");
                $ha->save();
                return redirect()->route('DSHinhAnh',['id' => $id1]);
            }
        }
        else{
            return view('login');
        }

    }
    public function XLDangXuat()
    {
    session()->flush('username');
    session()->flush('password');
    return redirect()->route('login');
    }
}
