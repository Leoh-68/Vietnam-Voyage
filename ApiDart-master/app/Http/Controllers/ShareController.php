<?php

namespace App\Http\Controllers;
use App\Models\Share;
use App\Models\DiaDanh;
use App\Models\HinhAnhDiaDanh;
use Illuminate\Http\Request;

class ShareController extends Controller
{
  public function LayDiaDanhTheoId(Request $req)
  {
    $dd=Share::find($req->id)->layDiaDanhTheoId;
    return $dd;
  }

  public function LayDiaDanhHotNhat()
  {
    $sl=0;
    $dem=1;
    $dd=DiaDanh::all();
    foreach($dd as $var)
    {
        $share=Share::where('DiaDanhId',$var->id)->count();        
        if($dem==1)
        {
            $sl=$share;
            $dem=2;
        }
        else if($share > $sl )
        {
            $sl =$share;
        }    
    }
    foreach($dd as $var)
    {
        $share=Share::where('DiaDanhId',$var->id)->count();        
        if($sl== $share)  
        {
            $share=Share::where('DiaDanhId',$var->id)->first();
            $diadanh=DiaDanh::find($share->DiaDanhId);
            return response()->json($diadanh, 200);
        }
    }
  }
}
