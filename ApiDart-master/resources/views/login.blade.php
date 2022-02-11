<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Webpixels">
    <title>Login</title>
    <!-- Preloader -->
    <style>
        @keyframes hidePreloader {
            0% {
                width: 100%;
                height: 100%;
            }

            100% {
                width: 0;
                height: 0;
            }
        }

        body>div.preloader {
            position: fixed;
            background: white;
            width: 100%;
            height: 100%;
            z-index: 1071;
            opacity: 0;
            transition: opacity .5s ease;
            overflow: hidden;
            pointer-events: none;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        body:not(.loaded)>div.preloader {
            opacity: 1;
        }

        body:not(.loaded) {
            overflow: hidden;
        }

        body.loaded>div.preloader {
            animation: hidePreloader .5s linear .5s forwards;
        }
    </style>
    <script>
        window.addEventListener("load", function() {
            setTimeout(function() {
                document.querySelector('body').classList.add('loaded');
            }, 300);
        });
    </script>
    <!-- Favicon -->
    <link rel="stylesheet" href="{{ asset('assets/libs/@fortawesome/fontawesome-free/css/all.min.css') }}">
    <link rel="icon" href="{{ asset('assets/img/brand/E.png') }}" type="image/png"> <!-- logo E trên thanh tag -->
    <!-- Quick CSS -->
    <link rel="stylesheet" href="{{ asset('assets/css/quick-website.css') }}" id="stylesheet">
</head>

<body>
    <!-- Main content -->
    <section>
        <div class="container d-flex flex-column">
            <div class="row align-items-center justify-content-center min-vh-100">
                <div class="col-md-6 col-lg-5 col-xl-5 py-6 py-md-0">
                    <div class="card shadow zindex-100 mb-0">
                        <div class="card-body px-md-5 py-5">
							 <span class="clearfix"></span>
                            <form  action="{{ route('xl-dang-nhap') }}" method="POST">
                            @csrf
                            <div class="mb-5">
                                <h6 class="h3">Đăng nhập</h6>
                            </div>
                            @php
	    		                $message = Session::get('message');
	    		                if($message){
		   			                echo '<span class="alert alert-danger">'.$message.'
                                       <button type="button" class="close" data-dismiss="alert">x</button>
                                    </span>';
		    		                Session::put('message',null);
	    		                }
	    		            @endphp
				            @php 
				                $title = Session::get('title');
				                if($title){
						            echo '<div class="alert alert-success">'.$title.'
                                    <button type="button" class="close" data-dismiss="alert">x</button>
                                    </div>';
						            Session::put('title',null);
				                }
				            @endphp
				            @php 
				                $Text = Session::get('Text');
				                if($Text){
						            echo '<div class="alert alert-danger">'.$Text.'
                                    <button type="button" class="close" data-dismiss="alert">x</button>
                                    </div>
                                    ';
						            Session::put('Text',null);
				                }
				            @endphp
                            @error('password')				
						                <span class="alert alert-danger">{{ $message }}</span>
					        @enderror
                            @error('username')
						                <span class="alert alert-danger">{{ $message }}</span>
					        @enderror
                           
                                <div class="form-group">
                                    <label class="form-control-label">Tài khoản</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="user"></i></span>
                                        </div>
                                        <input type="text" class="input100 @error('username') is-invalid @enderror" name="username" value="{{ old('username') }}" required>
                                    </div>
                                    
                                </div>
                                <div class="form-group mb-0">
                                    <div class="d-flex align-items-center justify-content-between">
                                        <div>
                                            <label class="form-control-label">Mật khẩu</label>
                                        </div>
                                    </div>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i data-feather="key"></i></span>
                                        </div>
                                        <input class="input100 @error('password') is-invalid @enderror " type="password" name="password" value="{{ old('password') }}" required>
                                    </div>
                                   
                                </div>
                                <div class="mt-4">
                                    <button type="submit" class="btn btn-block btn-primary">Đăng nhập</button></div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Core JS  -->
    <script src="{{ asset('assets/libs/jquery/dist/jquery.min.js') }}"></script>
    <script src="{{ asset('assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js') }}"></script>
    <script src="{{ asset('assets/libs/svg-injector/dist/svg-injector.min.js') }}"></script>
    <script src="{{ asset('assets/libs/feather-icons/dist/feather.min.js') }}"></script>
    <!-- Quick JS -->
    <script src="{{ asset('assets/js/quick-website.js') }}"></script>
    <!-- Feather Icons -->
    <script>
        feather.replace({
            'width': '1em',
            'height': '1em'
        })
    </script>
</body>

</html>