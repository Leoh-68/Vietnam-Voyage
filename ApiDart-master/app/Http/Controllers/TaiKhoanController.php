<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\TaiKhoan;
use App\Models\LuuTru;
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
    public function layTaiKhoan(Request $req)
    {
        $tk=TaiKhoan::where([['UserName',$req->username],['Password',$req->password]])->first();
        return $tk;
    }
    public function layTaiKhoanid(Request $req)
    {
        $tk=TaiKhoan::find($req->id);
        return $tk;
    }
    public function register(Request $req)
    {
        if($req->username==null||$req->password==null||$req->hoten==null||$req->email==null||$req->sdt==null)
        {
            return 2;
        }
        $tk=new TaiKhoan();
        $tk->UserName=$req->username;
        $tk->Password=$req->password;
        $tk->HoTen=$req->hoten;
        $tk->Email=$req->email;
        $tk->SDT=$req->sdt;
        $tk->hinhanh="3.jpg";
        $tk->save();
        return 1;
    }

   public function checkTrung(Request $req)
   {
    $tk=TaiKhoan::where([['UserName',$req->username],['Password',$req->password]])->count();
    return $tk;
   }
   public function image(Request $req)
   {
       $image=$req->image;
       return View('image',compact('image'));
   }
    public static function gettaikhoan($username)
    {
        $tk = TaiKhoan::where('username',$username)->first();
        return $tk;
    }
}
