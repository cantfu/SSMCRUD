package com.cantfu.crud.constant;

/**
 * 返回给浏览器的结果状态码
 * @author cantfu
 */
public enum ResultEnum {

    /**
     * 返回成功
     */
    SUCCESS("0000","处理成功"),
    /**
     * 返回失败
     */
    ERROR("1111", "处理失败"),

    /**
     * 等待处理
     */
    WAIT("9999", "等待处理");

    private String code;

    private String msg;

    ResultEnum(String code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}

