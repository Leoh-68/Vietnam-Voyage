<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HinhAnhDiaDanh extends Model
{
  use HasFactory;
    protected $table='hinhanhdiadanh';
    protected $fillable = [
      'DiaDanhId',
      'DuongDan',
  ];

    public function DiaDanh()
  {
      return $this->belongsTo(DiaDanh::class, 'DiaDanhId','id');
  }
}
