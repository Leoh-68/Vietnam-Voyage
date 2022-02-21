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
    <form action="{{ route('XLThemDiaDanh') }}" method="POST" enctype="multipart/form-data">
        @csrf
        <div class="">
            @if (session()->has('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session()->get('success') }}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            @endif
            @if (session()->has('fail'))
                <div class="alert alert-danger" style="width: 500px">
                    {{ session()->get('fail') }}
                </div>
            @endif
            <div class="container">
                <a class="btn btn-primary" href="{{ route('DiaDanh') }}"><i class="fa fa-arrow-alt-circle-left"></i> Quay
                    lại</a>
                <div>
                    <br>
                    <div>
                        <div class="input">
                            <label>Tên địa danh</label><span id="font"> *</span>
                            <br>
                            <input type="text" name="tendiadanh" />
                            @error('tendiadanh')
                                <br>
                                <span id="font">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="fixedbox">
                            <label>Vị Trí Tọa Độ</label><span id="font"> *</span>
                            <br>
                            X:
                            <input type="text" name="kinhdo" />
                            Y:
                            <input type="text" name="vido" />
                            @error('kinhdo')
                                <br>
                                <span id="font">{{ $message }}</span>
                            @enderror
                            @error('vido')
                                <br>
                                <span id="font">{{ $message }}</span>
                            @enderror
                        </div>

                    </div>
                    <br>
                    <div>
                        <label>Nội dung</label>
                        <br>
                        <textarea name="noidung" cols="100" rows="16"></textarea>
                    </div>
                    <div>
                        <label>Vị trí</label>
                        <br>
                        <textarea name="vungmien" cols="30" rows="10"></textarea>
                    </div><br>
                    <div style="float: left">
                        <select id="nhucau" name="nhucau">
                            <option value="Phượt">Phượt</option>
                            <option value="Nghĩ dưỡng">Nghĩ dưỡng</option>

                          </select>
                    </div><br><br>
                    <div class="form-group">
                        <label for="">Hình ảnh</label>
                        <input type="file" class="form-control" name="image">
                        @error('classcode')
                            <span style="color: red">{{ $message }}</span>
                        @enderror
                    </div>
                    <br>
                    <div>
                        <button class="btn btn-primary" type="submit">Thêm <i class="fa fa-check"></i></button>
                    </div>
                </div>
            </div>
        </div>
    </form>
@endsection
