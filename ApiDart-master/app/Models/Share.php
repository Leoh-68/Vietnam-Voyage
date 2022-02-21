<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Share extends Model
{
    protected $table = 'chiase';
    use HasFactory;
    protected $fillable = [
        'BaiViet',
        'DanhGia',
        'DiaDanhId',
        'TaiKhoanId',
        'Liked',
        'Unliked',
    ];
    public function DiaDanh()
    {
        return $this->belongsTo(DiaDanh::class, 'DiaDanhId');
    }
    public function TaiKhoan()
    {
        return $this->belongsTo(TaiKhoan::class, 'TaiKhoanId');
    }
}
