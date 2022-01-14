<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTableDb extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('dia_danhs', function (Blueprint $table) {
            $table->id();
            $table->String('TenDiaDanh');
            $table->String('ViTri');
            $table->String('MoTa');
            $table->String('HinhAnh');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('hinh_anh_share', function (Blueprint $table) {
            $table->id();
            $table->String('ShareId');
            $table->String('DuongDan');
            $table->timestamps();
            $table->softDeletes();
        });

        Schema::create('share', function (Blueprint $table) {
            $table->id();
            $table->String('BaiViet');
            $table->String('DanhGia');
            $table->String('DiaDanhId');
            $table->String('TaiKhoanId');
            $table->String('Liked');
            $table->String('Unliked');
            $table->timestamps();
            $table->softDeletes();
        });

        
        Schema::create('tai_khoan', function (Blueprint $table) {
            $table->id();
            $table->String('UserName');
            $table->String('Password');
            $table->String('HoTen');
            $table->String('Email');
            $table->String('SDT');
            $table->Boolean('Status');
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::create('DiaDiemLuuTru', function (Blueprint $table) {
            $table->id();
            $table->String('DiaDanhId');
            $table->String('TenLuuTru');
            $table->String('DiaChi');
            $table->String('SDT');
            $table->String('Status');
            $table->timestamps();
            $table->softDeletes();
        });
        Schema::create('ViTri', function (Blueprint $table) {
            $table->id();
            $table->String('DiaDanhId');
            $table->String('KinhDo');
            $table->String('ViDo');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('table_db');
    }
}
