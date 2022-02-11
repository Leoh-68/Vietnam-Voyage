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
use Illuminate\Http\Request;
use Illuminate\Support\Arr;

class DiaDanhController extends Controller
{
    public function LayDiaDanh()
    {
        $dd = DiaDanh::all();
        return response()->json($dd, 200);
    }

    public function TimKiem(Request $req)
    {

        $dd = DiaDanh::where('TenDiaDanh', "like", '%' . $req->name . '%')->get();
        return response()->json($dd, 200);
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

        $vitri = ToaDo::where('DiaDanhId', $req->id)->first();
        return response()->json($vitri);
    }
    public function luutru(Request $req)
    {
        $data=LuuTru::where('DiaDanhId',$req->id)->get();
        return $data;
    }
}
