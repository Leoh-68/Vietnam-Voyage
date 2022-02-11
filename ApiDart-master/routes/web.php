<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DangNhapController;

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
})->name('/');
Route::get('/login', [DangNhapController::class,'xulyTaiKhoan'])->name('login');
Route::post('/login', [DangNhapController::class,'xuLyDangNhap'])->name('xl-dang-nhap');
Route::get('/Admin/Students', [StudentController::class, 'layDanhSachSV'])->name('StudentsList');