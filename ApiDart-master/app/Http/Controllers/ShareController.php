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

  public function baiShare(Request $req)
  {
    $share= new Share();
    $share->DiaDanhId=$req->id;
    $share->BaiViet=$req->BaiViet;
    $share->DanhGia=$req->DanhGia;
    $share->TaiKhoanId=$req->TaiKhoanID;
    $share->Liked=0;
    $share->Unliked=0;
    $share->save();
    return 0;
  }

  public function baiShareHome()
  {
      $share=Share::all();
      return $share;
  }
  public function likePost(Request $req)
  {
    $share=Share::find($req->id);
    $share->Liked+=1;
    $share->save();
    return $share->Liked;
  }

  public function relikePost(Request $req)
  {
    $share=Share::find($req->id);
    $share->Liked-=1;
    $share->save();
    return $share->Liked;
  }

  public function unlikePost(Request $req)
  {
    $share=Share::find($req->id);
    $share->Unliked+=1;
    $share->save();
    return $share->Unliked;
  }

  public function reunlikePost(Request $req)
  {
    $share=Share::find($req->id);
    $share->Unliked-=1;
    $share->save();
    return $share->Unliked;
  }
}
