<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\ToaDo;
class ViTriController extends Controller
{
 public function logkt(Request $req)
 {
  if( strlen($req->user)==strlen($req->pass))
  {
      return "Thành công";
  }
  else
  {
      return "Thất bại";
  }
 }
}
