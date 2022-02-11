<?php

use Illuminate\Support\Facades\Route;
use  App\Http\Controllers\TaiKhoanController;
use  App\Http\Controllers\DiaDanhController;
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
