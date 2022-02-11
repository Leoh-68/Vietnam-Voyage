
<!DOCTYPE html>
<html lang="en">
@yield('html')
<head>  
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    {{-- CSS --}}
    <link rel="stylesheet" href="{{ asset('css/admin.css') }}" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    {{-- JavaScript --}}
    <script src="{{ asset('js/js.js') }}" ></script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
    {{-- Fontware --}}
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/fontawesome.min.css" integrity="sha384-jLKHWM3JRmfMU0A5x5AkjWkw/EYfGUAGagvnfryNV3F9VqM98XiIH7VBGVoxVSc7" crossorigin="anonymous">
    @yield('library')
    @yield('title')
</head>
<body class="bodyadmin">
    <header>
          <span></span>
        <a href="#" class="logo">E-Learning Project</a>
        <ul>
        {{Auth::user()->hoten;}}
            @php
                $account=Auth::user()->hinhanh;
            @endphp
            <li>
                <a href="{{route('loadAccount')}}"><img src="{{ asset('images/'.$account) }}" alt="Avatar" class="avatarnavbar"></a>
            </li>
            <a href="{{route('dangXuat')}}"><img src="{{ asset('images/logout.png') }}" alt="Avatar" class="avatarnavbar"></a>    
             <li> 

            </li>
        </ul>
    </header>
    <div class="classbody">
        <div class="container">
            <a id="btn" class="btn btn-primary" href="{{route('TeachersList')}}">Quản lý Giảng viên</a>
            <a id="btn" class="btn btn-primary" href="{{route('StudentsList')}}">Quản lý Sinh viên</a>
            <a id="btn" class="btn btn-primary" href="{{route('ClassroomsList')}}">Quản lý lớp học</a>
            <a id="btn" class="btn btn-danger" style="float:right" href="{{route('AdminsList')}}">Quản lý tài khoản quản trị viên</a>
        </div>
    </div>
     @yield('func')
</body>

</html>
