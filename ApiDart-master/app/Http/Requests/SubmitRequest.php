<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class SubmitRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'tendiadanh' => 'required',
            'kinhdo' => 'required',
            'vido' => 'required',
        ];
    }
    public function messages()
    {
        return[
            'tendiadanh.required' => 'Chưa nhập tên địa danh',
            'kinhdo.required' => 'Chưa nhập kinh độ',
            'vido.required' => 'Chưa nhập vĩ độ',
        ];
    }
}
