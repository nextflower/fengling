package com.fengling.cms.lucene;

import java.util.Map;

import com.fengling.common.web.freemarker.DirectiveUtils;

import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public abstract class SolrDirectiveAbstract implements TemplateDirectiveModel {
	
	/**
	 * 输入参数，搜索关键字
	 */
	public static final String PARAM_QUERY = "q";
	
	/**
	 * 根据参数名获取参数值
	 * @param params
	 * @param name
	 * @return
	 * @throws TemplateException
	 */
	protected String getParamByName(Map<String, TemplateModel> params, String name) throws TemplateException {
		return DirectiveUtils.getString(name, params);
	}

}
