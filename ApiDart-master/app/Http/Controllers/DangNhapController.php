<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Requests\DangNhapRequest;
use Illuminate\Support\Facades\Auth;
use App\Models\TaiKhoan;

class DangNhapController extends Controller
{
    public function xulyTaiKhoan()
    {
        if(session()->has('username')&&session()->has('password')){
            if(session('username') == "admin") {
                return redirect()->route('DiaDanh');
            }
        }
        else{
            return view('login');
        }
    }
    public function messages()
    {
        return [
            'username.required' => 'Chưa nhập tên đăng nhập',
            'password.required' => 'Chưa nhập mật khẩu',
            'password.min'=>'Password chứa ít nhất 5 ký tự',
            'email.required' => 'Chưa nhập email',
            'email.gmail' => 'Định dạng email không đúng',
        ];
    }
    public function xuLyDangNhap(DangNhapRequest $request)
    {
        $dstaikhoan = TaiKhoan::all();
        foreach($dstaikhoan as $tk){
            if ($tk->UserName==$request->username&&$tk->Password==$request->password) {
                session(['username' => $request->username]);
                session(['password' => $request->password]);
                if($tk->username=="admin") {
                    return redirect()->route('DiaDanh');
                }
            }
        }
        return redirect()->route('login')->with('Text','Username hoặc password không tồn tại');
    }
}
