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
    if($sl==0)
    {
        $a=DiaDanh::all()->where('deleted_at',null);
        foreach ($a as $var)
        {
            $diadanh=DiaDanh::find($var->id);
        }
        return response()->json($diadanh, 200);
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
    $share->idshare=0;
    $share->View=0;
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
    $new=new Share();
    $new->DiaDanhId=$share->DiaDanhId;
    $new->BaiViet=$share->BaiViet;
    $new->DanhGia=$share->DanhGia;
    $new->TaiKhoanId=$req->idaccount;
    $new->Liked=1;
    $new->Unliked=0;
    $new->idshare=$share->id;
    $new->View=0;
    $new->save();
    $share->View+=1;
    $like=Share::where([['idshare',$share->id],['Liked','1']])->count();
    return $like;
  }

  public function relikePost(Request $req)
  {
    $share=Share::find($req->id);
    $new=Share::where([['idshare',$share->id],['TaiKhoanId',$req->idaccount]]);
    $new->delete();
    $like=Share::where([['idshare',$share->id],['Liked','1']])->count();
    return $like;
  }

  public function unlikePost(Request $req)
  {
    $share=Share::find($req->id);
    $new=new Share();
    $new->DiaDanhId=$share->DiaDanhId;
    $new->BaiViet=$share->BaiViet;
    $new->DanhGia=$share->DanhGia;
    $new->TaiKhoanId=$req->idaccount;
    $new->Liked=0;
    $new->Unliked=1;
    $new->idshare=$share->id;
    $new->View=0;
    $new->save();
    $like=Share::where([['idshare',$share->id],['Unliked','1']])->count();
    return $like;
  }

  public function reunlikePost(Request $req)
  {
    $share=Share::find($req->id);
    $new=Share::where([['idshare',$share->id],['TaiKhoanId',$req->idaccount]]);
    $new->delete();
    $like=Share::where([['idshare',$share->id],['Unliked','1']])->count();
    return $like;
  }
  //Lấy số like, unlike bài viết
  public function countlike(Request $req)
  {
    $like=Share::where([['idshare',$req->id],['Liked','1']])->count();
    return $like;
  }
  public function countunlike(Request $req)
  {
    $like=Share::where([['idshare',$req->id],['Unliked','1']])->count();
    return $like;
  }
  //kiem tra da unlike, like
  public function liked(Request $req)
  {

      $post=Share::where([['TaiKhoanId',$req->idaccount],['idshare',$req->idshare],['Liked','1']])->count();
      if($post==0)
      {
       return 0;
      }
      else
      {
          return 1;
      }
  }
  public function unliked(Request $req)
  {
      $post=Share::where([['TaiKhoanId',$req->idaccount],['idshare',$req->idshare],['Unliked','1']])->count();
      if($post==0)
      {
       return 0;
      }
      else
      {
          return 1;
      }
  }
}
