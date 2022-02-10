<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\TaiKhoan;

class AddAccount extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        #Tài Khoản Admin
        $account=new TaiKhoan();
        $account->username = 'admin';
        $account->password = 'admin';
        $account->hoten = 'admin';
        $account->sdt = '0';
        $account->email = 'admin@admin.admin';
        $account->save();
        #Tài khoản Người dùng 1
        $account1=new TaiKhoan();
        $account1->username = 'User1';
        $account1->password = '123456';
        $account1->hoten = '123456';
        $account1->sdt = '0';
        $account1->email = 'User1@User1.User1';
        $account1->save();
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
