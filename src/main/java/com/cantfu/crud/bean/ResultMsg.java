package com.cantfu.crud.bean;

import com.cantfu.crud.constant.ResultEnum;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;

import java.util.HashMap;
import java.util.Map;

/**
 * ResultMsg
 * 请求返回的结果封装，带上状态码
 * @author cantfu
 * @date 2019/3/26
 */
@JsonInclude(JsonInclude.Include.NON_NULL)
@Getter
public class ResultMsg {

    private String code;

    private String msg;

    private Map<String, Object> data = new HashMap<>();

    ResultMsg(){}

    private ResultMsg(ResultEnum resultEnum) {
        this.code = resultEnum.getCode();
        this.msg = resultEnum.getMsg();
    }

    /**
     * 响应请求成功
     * @return
     */
    public static ResultMsg success(){
        return new ResultMsg(ResultEnum.SUCCESS);
    }
    /**
     * 响应请求失败
     * @return
     */
    public static ResultMsg error(){
        return new ResultMsg(ResultEnum.ERROR);
    }
    /**
     * 响应请求处理中
     * @return
     */
    public static ResultMsg process(){
        return new ResultMsg(ResultEnum.WAIT);
    }


    public ResultMsg add(String key, Object value){
        this.data.put(key,value);
        return this;
    }

}
