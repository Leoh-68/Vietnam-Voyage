<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use App\Models\DiaDanh;
class Seed extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        for($i=0;$i<7;$i++)
        {
            $dd=new DiaDanh;
            $dd->TenDiaDanh="Nhà Khánh";
            $dd->ViTri="Nhà Khánh Nè";
            $dd->MoTa=":>";
            $dd->HinhAnh=$i;
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
