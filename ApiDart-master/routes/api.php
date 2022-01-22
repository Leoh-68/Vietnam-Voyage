<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\DiaDanhController;
use  App\Http\Controllers\ShareController;
use  App\Http\Controllers\TaiKhoanController;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('DiaDanh',[DiaDanhController::class,'LayDiaDanh']);
Route::get('TaiKhoan',[DiaDanhController::class,'GetTaiKhoan']);

Route::post('TimKiem',[DiaDanhController::class,'TimKiem']);

Route::post('LayHinhAnhTheoDiaDanh', [DiaDanhController::class,'LayHinhAnhTheoDiaDanh']);

Route::post('LayDiaDanhTheoId', [ShareController::class,'LayDiaDanhTheoId']);

Route::post('LayDiaDanhHotNhat', [ShareController::class,'LayDiaDanhHotNhat']);

Route::post('CheckTaiKhoan', [TaiKhoanController::class,'dangnhap']);

Route::get('LayDSTaiKhoan', [TaiKhoanController::class,'laydstaikhoan']);