package com.fengling.cms.action.directive;

import static com.fengling.cms.Constants.TPL_STYLE_LIST;
import static com.fengling.cms.Constants.TPL_SUFFIX;
import static com.fengling.common.web.Constants.UTF8;
import static com.fengling.common.web.freemarker.DirectiveUtils.OUT_LIST;
import static com.fengling.core.web.util.FrontUtils.PARAM_STYLE_LIST;
import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.fengling.cms.action.directive.abs.AbstractSimpleContentDirective;
import com.fengling.cms.entity.main.Content;
import com.fengling.common.web.freemarker.DirectiveUtils;
import com.fengling.common.web.freemarker.ParamsRequiredException;
import com.fengling.common.web.freemarker.DirectiveUtils.InvokeType;
import com.fengling.core.entity.CmsSite;
import com.fengling.core.web.util.FrontUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * 内容列表标签
 */
public class SimpleContentListDirective extends AbstractSimpleContentDirective {
	/**
	 * 模板名称
	 */
	public static final String TPL_NAME = "content_list";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		CmsSite site = FrontUtils.getSite(env);
		List<Content> list = (List<Content>) super.getData(params, env);

		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
		paramWrap.put(OUT_LIST, DEFAULT_WRAPPER.wrap(list));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		InvokeType type = DirectiveUtils.getInvokeType(params);
		String listStyle = DirectiveUtils.getString(PARAM_STYLE_LIST, params);
		if (InvokeType.sysDefined == type) {
			if (StringUtils.isBlank(listStyle)) {
				throw new ParamsRequiredException(PARAM_STYLE_LIST);
			}
			env.include(TPL_STYLE_LIST + listStyle + TPL_SUFFIX, UTF8, true);
		} else if (InvokeType.userDefined == type) {
			if (StringUtils.isBlank(listStyle)) {
				throw new ParamsRequiredException(PARAM_STYLE_LIST);
			}
			FrontUtils.includeTpl(TPL_STYLE_LIST, site, env);
		} else if (InvokeType.custom == type) {
			FrontUtils.includeTpl(TPL_NAME, site, params, env);
		} else if (InvokeType.body == type) {
			body.render(env.getOut());
		} else {
			throw new RuntimeException("invoke type not handled: " + type);
		}
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}

	@Override
	protected boolean isPage() {
		return false;
	}
}
