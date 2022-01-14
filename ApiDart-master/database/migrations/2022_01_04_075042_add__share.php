<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\Share;
class AddShare extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $a=0;
        for($i=0;$i<7;$i++)
        {
            $dd=new Share;
            $dd->BaiViet="Nơi này rất đẹp";
            $dd->DanhGia="5s";
            $dd->DiaDanhId=$a+$i+1;
            $dd->TaiKhoanId=$a+$i+1;
            $dd->Liked=1;
            $dd->Unliked=0;
            $dd->save();
        }
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
