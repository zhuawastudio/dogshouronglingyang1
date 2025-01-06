package com.entity.view;

import com.entity.LingyanghuifangEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;

/**
 * 领养回访
 * 后端返回视图实体辅助类
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email
 * @date 2021-04-12
 */
@TableName("lingyanghuifang")
public class LingyanghuifangView extends LingyanghuifangEntity implements Serializable {
    private static final long serialVersionUID = 1L;



	public LingyanghuifangView() {

	}

	public LingyanghuifangView(LingyanghuifangEntity lingyanghuifangEntity) {
		try {
			BeanUtils.copyProperties(this, lingyanghuifangEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}














}
