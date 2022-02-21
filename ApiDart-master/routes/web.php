<?php
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\TaiKhoanController;
use  App\Http\Controllers\DiaDanhController;
use App\Http\Controllers\DangNhapController;
use App\Http\Controllers\AdminController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});


Route::post('/',[DiaDanhController::class,'ThemDiaDanh'])->name("add");


Route::get('/image',[TaiKhoanController::class,'image'])->name("image");
Route::get('/', [DangNhapController::class,'xulyTaiKhoan'])->name('login');
Route::post('/', [DangNhapController::class,'xuLyDangNhap'])->name('xl-dang-nhap');
Route::get('/Admin/DiaDanh', [AdminController::class, 'DSDiaDanh'])->name('DiaDanh');
Route::get('/Admin/ThemDiaDanh', [AdminController::class, 'ThemDiaDanh'])->name('ThemDiaDanh');
Route::post('/Admin/ThemDiaDanh', [AdminController::class, 'xlThemDiaDanh'])->name('XLThemDiaDanh');
Route::get('/Admin/SuaDiaDanh/{id}', [AdminController::class, 'SuaDiaDanh'])->name('SuaDiaDanh');
Route::post('/Admin/SuaDiaDanh/{id}', [AdminController::class, 'XLSuaDiaDanh'])->name('XLSuaDiaDanh');
Route::get('/Admin/XoaDiaDanh/{id}', [AdminController::class, 'XLXoaDiaDanh'])->name('XoaDiaDanh');
Route::get('/Admin/DSHinhAnh/{id}', [AdminController::class, 'DSHinhAnh'])->name('DSHinhAnh');
Route::get('/Admin/ThemHinhAnh/{id}', [AdminController::class, 'ThemHinhAnh'])->name('ThemHinhAnh');
Route::post('/Admin/ThemHinhAnh/{id}', [AdminController::class, 'XLThemHinhAnh'])->name('XLThemHinhAnh');
Route::get('/Admin/SuaHinhAnh/{idhinhanh}/{id}', [AdminController::class, 'SuaHinhAnh'])->name('SuaHinhAnh');
Route::post('/Admin/SuaHinhAnh/{idhinhanh}/{id}', [AdminController::class, 'XLSuaHinhAnh'])->name('XLSuaHinhAnh');
Route::get('/Admin/XoaHinhAnh/{idhinhanh}/{id}', [AdminController::class, 'XLXoaHinhAnh'])->name('XoaHinhAnh');
Route::get('/dangxuat',[AdminController::class, 'XLDangXuat'] )->name('DangXuat');
