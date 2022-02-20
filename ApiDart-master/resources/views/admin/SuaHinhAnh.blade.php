@extends('layouts.AdminPage')
 @section('library')
 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <!-- CSRF Token -->
 <meta name="csrf-token" content="{{ csrf_token() }}">
 <title>{{ config('app.name', 'Laravel') }}</title>
 <!-- Scripts -->
 <script src="{{ asset('js/app.js') }}" defer></script>
 <!-- Fonts -->
 <link rel="dns-prefetch" href="//fonts.gstatic.com">
 <link href="https://fonts.googleapis.com/css?family=Nunito" rel="stylesheet">
 <!-- Styles -->
 <link href="{{ asset('css/app.css') }}" rel="stylesheet">
 {{-- link --}}

 @endsection
 @section('html')
 <html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
 @endsection
 @section('func')
 <form action="{{route('XLSuaHinhAnh',['id'=>request()->id,'idhinhanh'=>request()->idhinhanh])}}" method="POST" enctype="multipart/form-data">
 @csrf
    <div class="">
        <div class="container">
        <a class="btn btn-primary" href="{{route('DSHinhAnh',['id' => request()->idhinhanh])}}"><i class="fa fa-arrow-alt-circle-left"></i> Quay lại</a>
            <div>
                <br>
                <div>
                    <img src="{{ asset('images/'.$ha->duongdan) }}" style="height:500px">
                    <br>
                    <div class="input">
                        <label>Hình ảnh</label><span id="font"> *</span>
                        <br>
                        <input type="file" name="image"/>
                    </div>
                </div>
                <br>
                <br>
                <div>
                    <button class="btn btn-primary" type = "submit">Sửa <i class="fa fa-check"></i></button>
                </div>
            </div>
        </div>
    </div>
</form>
 @endsection


