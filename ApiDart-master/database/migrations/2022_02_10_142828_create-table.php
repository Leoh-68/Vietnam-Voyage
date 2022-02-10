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
            $table->string('username');
            $table->string('password');
            $table->string('hoten');
            $table->string('sdt',10)->default('0');
            $table->string('email');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('vitri', function (Blueprint $table) {
            $table->id();
            $table->double('kinhdo');
            $table->double('vido');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('diadanh', function (Blueprint $table) {
            $table->id();
            $table->string('tendiadanh');
            $table->integer('vitriid');
            $table->foreign('vitriid')->references('id')->on('vitri');
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
            $table->string('noidung');
            $table->integer('diadanhid');
            $table->foreign('diadanhid')->references('id')->on('diadanh');
            $table->integer('taikhoanid');
            $table->foreign('taikhoanid')->references('id')->on('taikhoan');
            $table->timestamps();
            $table->SoftDeletes();
        });
        Schema::create('diadiemluutru', function (Blueprint $table) {
            $table->id();
            $table->integer('diadanhid');
            $table->foreign('diadanhid')->references('id')->on('diadanh');
            $table->string('tenluutru');
            $table->string('diachi');
            $table->string('SDT',10)->default('0');
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
