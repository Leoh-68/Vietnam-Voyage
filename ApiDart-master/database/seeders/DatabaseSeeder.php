<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
          for($i=0;$i<7;$i++)
        {
            $dd=new DiaDanh;
            $dd->TenDiaDanh="Nhà Khánh";
            $dd->ViTri="Nhà Khánh Nè";
            $dd->MoTa=":>";
            $dd->save();
        }
    }
}
