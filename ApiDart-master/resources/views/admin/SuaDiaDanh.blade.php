@php 
use \App\Http\Controllers\AdminController;
@endphp
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
 <form action="{{route('XLSuaDiaDanh',['id'=>$dd->id])}}" method="POST" enctype="multipart/form-data">
 @csrf
    <div class="">
        <div class="container">
        <a class="btn btn-primary" href="{{route('DiaDanh')}}"><i class="fa fa-arrow-alt-circle-left"></i> Quay lại</a>
            <div>
                <br>
                <div>
                    <div class="input">
                        <label>Tên địa danh</label><span id="font"> *</span>
                        <br>
                        <input type="text" name="tendiadanh" value="{{$dd->tendiadanh}}"/>
                        @error('tendiadanh')
                        <br>
                        <span id="font">{{$message}}</span>
                        @enderror
                    </div>
                    <div class="fixedbox">
                        <label>Vị Trí</label><span id="font"> *</span>
                        <br>
                        X: 
                        <input type="text" name="kinhdo" value="{{ AdminController::LayX($dd->vitriid) }}"/>
                        Y:
                        <input type="text" name="vido" value="{{ AdminController::LayY($dd->vitriid) }}"/>
                        @error('kinhdo')
                        <br>
                        <span id="font">{{$message}}</span>
                        @enderror
                        @error('vido')
                        <br>
                        <span id="font">{{$message}}</span>
                        @enderror
                    </div>
                </div>
                <br>
                <div>
                        <label>Nội dung</label>
                        <br>
                        <textarea name="noidung" cols="100" rows="16">{{$dd->noidung}}</textarea>
                </div>
                <br>
                <div>
                    <button class="btn btn-primary" type = "submit">Thêm <i class="fa fa-check"></i></button>
                </div>
            </div>
        </div>
    </div>
</form>
 @endsection
 

