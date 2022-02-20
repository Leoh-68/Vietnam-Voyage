<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('taikhoan', function (Blueprint $table) {
            $table->id();
            $table->string('UserName');
            $table->string('Password');
            $table->string('HoTen');
            $table->string('hinhanh');
            $table->string('SDT',10)->default('0');
            $table->string('Email');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('vitri', function (Blueprint $table) {
            $table->id();
            $table->double('KinhDo');
            $table->double('ViDo');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('diadanh', function (Blueprint $table) {
            $table->id();
            $table->string('TenDiaDanh');
            $table->string('ViTri');
            $table->string('ViTriId');
            $table->string('MoTa');
            $table->String('NhuCauId');
            $table->string('HinhAnhId');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('nhucau', function (Blueprint $table) {
            $table->id();
            $table->string('LoaiNhuCau');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('hinhanhdiadanh', function (Blueprint $table) {
            $table->id();
            $table->integer('diadanhid');
            $table->foreign('diadanhid')->references('id')->on('diadanh');
            $table->string('duongdan');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('chiase', function (Blueprint $table) {
            $table->id();
            $table->string('BaiViet');
            $table->string('DiaDanhId');
            $table->foreign('DiaDanhId')->references('id')->on('diadanh');
            $table->string('TaiKhoanId');
            $table->foreign('TaiKhoanId')->references('id')->on('taikhoan');
            $table->string('View')->default('0');
            $table->string('Liked');
            $table->string('hinhanh');
            $table->string('idshare');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('diadiemluutru', function (Blueprint $table) {
            $table->id();
            $table->string('DiaDanhId');
            $table->foreign('DiaDanhId')->references('id')->on('diadanh');
            $table->string('TenLuuTru');
            $table->string('DiaChi');
            $table->string('SDT',10)->default('0');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('luotlike', function (Blueprint $table) {
            $table->id();
            $table->integer('DiaDanhId');
            $table->foreign('DiaDanhId')->references('id')->on('diadanh');
            $table->integer('PostId');
            $table->foreign('PostId')->references('id')->on('chiase');
            $table->string('Liked');
            $table->string('View');
            $table->timestamps();
            $table->SoftDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
