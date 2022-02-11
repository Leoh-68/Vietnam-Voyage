<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TaiKhoan;

class TaiKhoanController extends Controller
{
    public function dangnhap(Request $rq)
    {
        $user = TaiKhoan::where('username',$rq->username)->first();
        if($user!=null){
            return 1;
        }
    }
    public function laydstaikhoan()
    {
        $dstk = Taikhoan::all();
        return $dstk;
    }
    public static function gettaikhoan($username)
    {
        $tk = TaiKhoan::where('username',$username)->first();
        return $tk;
    }
}
