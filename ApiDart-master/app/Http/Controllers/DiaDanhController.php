<?php

namespace App\Http\Controllers;

use App\Models\DiaDanh;
use App\Models\TaiKhoan;
use App\Models\HinhAnhDiaDanh;
use App\Models\ToaDo;
use App\Models\LuuTru;
use App\Models\Share;
use App\Http\Requests\StoreDiaDanhRequest;
use App\Http\Requests\UpdateDiaDanhRequest;
use App\Models\LuotLike;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class DiaDanhController extends Controller
{
    public function LayDiaDanh()
    {

        $dd = DiaDanh::all();
        $count=0;
        foreach($dd as $var)
        {
            if(LuotLike::where('DiaDanhId',$var->id)->count()!=0)
            {
                $like=LuotLike::where('DiaDanhId',$var->id)->first();
                Arr::add($dd[$count],'luotlike',$like->Liked);
            }
            else
            {
                Arr::add($dd[$count],'luotlike',0);
            }
            if(Share::where([['DiaDanhId',$var->id],['idshare',0]])->count()!=0)
            {
                $share=Share::where([['DiaDanhId',$var->id],['idshare',0]])->count();
                Arr::add($dd[$count],'luotshare',$share);
            }
            else
            {
                Arr::add($dd[$count],'luotshare',0);
            }
            $count+=1;
        }
        return response()->json($dd, 200);
    }

    public function TimKiem(Request $req)
    {
        if($req->mode=="Tên địa danh")
        {
            $dd = DiaDanh::where('TenDiaDanh', "like", '%' . $req->name . '%')->get();
            return response()->json($dd, 200);
        }
        else
        {
            $dd= DiaDanh::where('ViTri', "like", '%' . $req->name . '%')->get();
            return response()->json($dd, 200);
        }

    }
    public function LayHinhAnhTheoDiaDanh(Request $req)
    {
        $dd = DiaDanh::find($req->id)->layHinhAnhTheoDiaDanh;
        if (!empty($dd))
            return response()->json($dd, 200);
        return response()->json($dd, 404);
    }
    public function GetTaiKhoan(Request $req)
    {
        $taikhoan = TaiKhoan::find($req->id);
        $dsShare = $taikhoan->Share;
        Arr::add($taikhoan, "Share", $dsShare);
        return response()->json($taikhoan);
    }

    function layToaDoTheoID(Request $req)
    {
        $dd=DiaDanh::find($req->id);
        $vitri = ToaDo::find($dd->ViTriId);
        return response()->json($vitri);
    }
    public function luutru(Request $req)
    {
        $data=LuuTru::where('DiaDanhId',$req->id)->get();
        return $data;
    }
    public function LayTheoVungMien()
    {
        # code...
    }
    public function ThayAnh(Request $rq)
    {
        $tk=TaiKhoan::find($rq->id);
        if ($rq->has('file')==false) {
            session()->flash('fail', 'Vui lòng chọn hình ảnh');
            return redirect()->back();
        }
        $size = $rq->file->getSize();
        $extention = $rq->file->extension();
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
            $image = $rq->file;
            $image_name = $image->getClientoriginalName();
            $image->move(public_path('images'), $image_name);
            $tk->hinhanh=$image_name;
            $tk->save();
        } else {
            session()->flash('fail', 'Tệp được chọn phải là hình ảnh');
            return redirect()->back();
        }
    }
    public function LuuAnh(Request $rq)
    {
        if ($rq->has('file')==false) {
            session()->flash('fail', 'Vui lòng chọn hình ảnh');
            return redirect()->back();
        }
        $size = $rq->file->getSize();
        $extention = $rq->file->extension();
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
            $image = $rq->file;
            $image_name = $image->getClientoriginalName();
            $image->move(public_path('images'), $image_name);
        } else {
            session()->flash('fail', 'Tệp được chọn phải là hình ảnh');
            return redirect()->back();
        }

    }
    public function PostSharee(Request $req)
    {
        $count=0;
      $share=Share::orderBy('created_at','desc')->where('DiaDanhId',$req->id)->get();
      foreach($share as $var)
      {
          $tk=TaiKhoan::find($var->TaiKhoanId);
          Arr::add($share[$count], "TaiKhoan", $tk);
          $like=Share::where([['TaiKhoanId',$req->tkid],['idshare',$var->id],['Liked','1']])->count();
          if($like==0)
          {
            Arr::add($share[$count], "isFavor", "ko");
          }
          else
          {
            Arr::add($share[$count], "isFavor", "co");
          }
          $count+=1;
      }

      return $share;
    }
    public function TheoNhuCau(Request $req)
    {
        if($req->nhucau=="Phượt")
        {
            $dd=DiaDanh::where('NhuCauId',1)->get();
            $count=0;
            foreach($dd as $var)
            {
                if(LuotLike::where('DiaDanhId',$var->id)->count()!=0)
                {
                    $like=LuotLike::where('DiaDanhId',$var->id)->first();
                    Arr::add($dd[$count],'luotlike',$like->Liked);
                }
                else
                {
                    Arr::add($dd[$count],'luotlike',0);
                }
                if(Share::where([['DiaDanhId',$var->id],['idshare',0]])->count()!=0)
                {
                    $share=Share::where([['DiaDanhId',$var->id],['idshare',0]])->count();
                    Arr::add($dd[$count],'luotshare',$share);
                }
                else
                {
                    Arr::add($dd[$count],'luotshare',0);
                }
                $count+=1;
            }
            return response()->json($dd);
        }
        else
        {
            $dd=DiaDanh::where('NhuCauId',2)->get();
            $count=0;
            foreach($dd as $var)
            {
                if(LuotLike::where('DiaDanhId',$var->id)->count()!=0)
                {
                    $like=LuotLike::where('DiaDanhId',$var->id)->first();
                    Arr::add($dd[$count],'luotlike',$like->Liked);
                }
                else
                {
                    Arr::add($dd[$count],'luotlike',0);
                }
                if(Share::where([['DiaDanhId',$var->id],['idshare',0]])->count()!=0)
                {
                    $share=Share::where([['DiaDanhId',$var->id],['idshare',0]])->count();
                    Arr::add($dd[$count],'luotshare',$share);
                }
                else
                {
                    Arr::add($dd[$count],'luotshare',0);
                }
                $count+=1;
            }
            return response()->json($dd);
        }
    }

}
