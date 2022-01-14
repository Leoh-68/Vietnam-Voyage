<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TaiKhoan;

class TaiKhoanController extends Controller
{
    public function dangnhap(Request $rq)
    {
        $user = TaiKhoan::where('UserName',$rq->username)->first();
        if($user == null){
            return 0;
        }
        else
        return 1;
    }
}
