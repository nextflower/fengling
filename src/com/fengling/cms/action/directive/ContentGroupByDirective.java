package com.fengling.cms.action.directive;

import static com.fengling.common.web.freemarker.DirectiveUtils.OUT_LIST;
import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.fengling.cms.manager.main.ContentMng;
import com.fengling.common.web.freemarker.DirectiveUtils;
import com.fengling.core.entity.CmsSite;
import com.fengling.core.web.util.FrontUtils;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateDirectiveModel;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

/**
 * 稿件分组查询标签
 */
public class ContentGroupByDirective implements TemplateDirectiveModel {
	/**
	 * 输入参数，广告ID。
	 */
	public static final String PARAM_ID = "id";
	/**
	 * 输入参数，栏目ID
	 */
	public static final String PARAM_CHANNEL_ID = "channelId";
	/**
	 * 分组字段
	 */
	public static final String PARAM_GROUP_BY = "groupby";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		
		CmsSite site = FrontUtils.getSite(env);
		
		//可用的查询条件
		Integer channelId = DirectiveUtils.getInt(PARAM_CHANNEL_ID, params);
		
		//分组字段
		String groupby = DirectiveUtils.getString(PARAM_GROUP_BY, params);
		
		Map<String, Integer> map = contentMng.getGroupResult(site.getId(), channelId, groupby);
		
		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(params);
		paramWrap.put(OUT_LIST, DEFAULT_WRAPPER.wrap(map));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		body.render(env.getOut());
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}

	@Autowired
	private ContentMng contentMng;
}
