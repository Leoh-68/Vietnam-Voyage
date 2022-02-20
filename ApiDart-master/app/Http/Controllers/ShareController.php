<?php

namespace App\Http\Controllers;
use App\Models\Share;
use App\Models\DiaDanh;
use App\Models\HinhAnhDiaDanh;
use App\Models\LuotLike;
use App\Models\TaiKhoan;
use Illuminate\Support\Arr;
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
      $hinhanh="";
      if($req->image!="")
      {
          $hinhanh=$req->Image;
      }
    $share= new Share();
    $share->DiaDanhId=$req->id;
    $share->BaiViet=$req->BaiViet;
    $share->TaiKhoanId=$req->TaiKhoanID;
    $share->Liked=0;
    $share->idshare=0;
    $share->View=0;
    $share->hinhanh=$hinhanh;
    $share->save();
    return "Chia sẻ thành công";
  }

  public function baiShareHome(Request $req)
  {
      $count=0;
      $share=Share::orderBy('created_at','desc')->get();
      foreach($share as $var)
      {
          $tk=TaiKhoan::find($var->TaiKhoanId);
          Arr::add($share[$count], "TaiKhoan", $tk);
          $like=Share::where([['TaiKhoanId',$req->tkid],['idshare',$var->id],['Liked','1']])->count();
          if($like==0)
          {
            Arr::add($share[$count], "isFavor", "ko");
          }
          else
          {
            Arr::add($share[$count], "isFavor", "co");
          }
          $count+=1;
      }

      return $share;
  }

  public function likePost(Request $req)
  {
    $share=Share::find($req->id);
    $new=new Share();
    $new->DiaDanhId=$share->DiaDanhId;
    $new->BaiViet=$share->BaiViet;
    $new->TaiKhoanId=$req->idaccount;
    $new->Liked=1;
    $new->idshare=$share->id;
    $new->View=0;
    $new->hinhanh="";
    $new->save();
    $share->View+=1;
    $share->save();
    $likecount=LuotLike::where('DiaDanhId',$share->DiaDanhId)->count();
    if($likecount==0)
    {
        $like=new LuotLike();
        $like->DiaDanhId=$share->DiaDanhId+0;
        $like->Liked=1;
        $like->View=1;
        $like->save();
        Arr::add($like, "isFavorite", "co");
        return $like;
    }
    else
    {
        $like=LuotLike::where('DiaDanhId',$share->DiaDanhId)->first();
        $like->Liked+=1;
        $like->View+=1;
        $like->save();
        Arr::add($like, "isFavorite", "co");
        return $like;
    }



  }

  public function relikePost(Request $req)
  {
    $share=Share::find($req->id);
    $new=Share::where([['idshare',$share->id],['TaiKhoanId',$req->idaccount]]);
    $new->delete();
    $like=LuotLike::where('DiaDanhId',$share->DiaDanhId)->first();
    $like->Liked-=1;
    $like->save();
    Arr::add($like, "isFavorite", "ko");
    return $like;
  }

//   public function unlikePost(Request $req)
//   {
//     $share=Share::find($req->id);
//     $new=new Share();
//     $new->DiaDanhId=$share->DiaDanhId;
//     $new->BaiViet=$share->BaiViet;
//     $new->DanhGia=$share->DanhGia;
//     $new->TaiKhoanId=$req->idaccount;
//     $new->Liked=0;
//     $new->Unliked=1;
//     $new->idshare=$share->id;
//     $new->View=0;
//     $new->save();
//     $like=Share::where([['idshare',$share->id],['Unliked','1']])->count();
//     return $like;
//   }

//   public function reunlikePost(Request $req)
//   {
//     $share=Share::find($req->id);
//     $new=Share::where([['idshare',$share->id],['TaiKhoanId',$req->idaccount]]);
//     $new->delete();
//     $like=Share::where([['idshare',$share->id],['Unliked','1']])->count();
//     return $like;
//   }
  //Lấy số like, unlike bài viết
//   public function countlike(Request $req)
//   {

//     return $count;
//   }
   public function countlike(Request $req)
  {
     $like=LuotLike::where('DiaDanhId',$req->id)->first();
     if($like ==null)
     {
         $like= new LuotLike();
         $like->DiaDanhId=$req->id+0;
         $like->Liked=0;
         $like->View=0;
     }
     $count=Share::where([['idshare',$req->idpost],['Liked','1']])->count();
    return $count;
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
