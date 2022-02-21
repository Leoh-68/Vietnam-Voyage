<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TaiKhoan extends Model
{
    protected $table = 'taikhoan';
    use HasFactory;

    public function Share()
    {
        return $this->hasMany(Share::class, 'TaiKhoanId');
    }
}
