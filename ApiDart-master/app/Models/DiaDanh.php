<?php

namespace App\Models;
use App\Models\HinhAnhDiaDanh;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DiaDanh extends Model
{
  use HasFactory;
    protected $table='diadanh';
    protected $fillable = [
      'TenDiaDanh',
      'ViTri',
      'MoTa',
      'HinhAnh',
  ];

  public function Share()
    {
        return $this->hasMany(Share::class, 'DiaDanhId');
    }
}
