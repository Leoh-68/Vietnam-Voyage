<?php

namespace App\Http\Controllers;

use App\Models\DiaDanh;
use App\Models\LuotLike;
use Illuminate\Http\Request;

class LuotLikeController extends Controller
{
    public function LayLuotLikeTheiID(Request $req)
    {
        $like=LuotLike::where('DiaDanhId',$req->id)->first();
        return $like;
    }

    public function laytop5()
    {
        $dd=collect();
       $like=LuotLike::orderBy('Liked','desc')->get()->take(5);
       foreach($like as $var)
       {
           $ddfind=DiaDanh::find($var->DiaDanhId);
           $dd->push($ddfind);
       }
       return $dd;
    }
}
