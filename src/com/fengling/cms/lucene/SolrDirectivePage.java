package com.fengling.cms.lucene;

import static com.fengling.cms.Constants.TPL_STYLE_LIST;
import static com.fengling.cms.Constants.TPL_SUFFIX;
import static com.fengling.common.web.Constants.UTF8;
import static com.fengling.common.web.freemarker.DirectiveUtils.OUT_LIST;
import static com.fengling.common.web.freemarker.DirectiveUtils.OUT_PAGINATION;
import static com.fengling.core.web.util.FrontUtils.PARAM_STYLE_LIST;
import static freemarker.template.ObjectWrapper.DEFAULT_WRAPPER;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.lucene.queryParser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;

import com.fengling.cms.Constants;
import com.fengling.cms.entity.main.Content;
import com.fengling.cms.manager.main.ContentMng;
import com.fengling.common.page.Pagination;
import com.fengling.common.web.freemarker.DirectiveUtils;
import com.fengling.common.web.freemarker.ParamsRequiredException;
import com.fengling.common.web.freemarker.DirectiveUtils.InvokeType;
import com.fengling.common.web.springmvc.RealPathResolver;
import com.fengling.core.entity.CmsSite;
import com.fengling.core.web.util.FrontUtils;
import com.fengling.search.solrmodule.condition.SolrSearchCondition;
import com.fengling.search.solrmodule.page.SolrResult;
import com.fengling.search.solrmodule.query.EPSSolrServerForFengLing;

import freemarker.core.Environment;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;

public class SolrDirectivePage extends SolrDirectiveAbstract {
	
	@Autowired
	private EPSSolrServerForFengLing solrServer;
	@Autowired
	private ContentMng contentMng;
	
	/**
	 * 模板名称
	 */
	public static final String TPL_NAME = "lucene_page";

	@SuppressWarnings("unchecked")
	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {
		
		CmsSite site = FrontUtils.getSite(env);
		int pageNo = FrontUtils.getPageNo(env);
		int count = FrontUtils.getCount(params);
		
		SolrSearchCondition condition = getCondition(params, site.getId());
		condition.setPageNo(pageNo);
		condition.setPageSize(count);
		
		SolrResult result = solrServer.query(condition);
		
		Pagination page = convert(result);

		Map<String, TemplateModel> paramWrap = new HashMap<String, TemplateModel>(
				params);
		paramWrap.put(OUT_PAGINATION, DEFAULT_WRAPPER.wrap(page));
		paramWrap.put(OUT_LIST, DEFAULT_WRAPPER.wrap(page.getList()));
		Map<String, TemplateModel> origMap = DirectiveUtils
				.addParamsToVariable(env, paramWrap);
		InvokeType type = DirectiveUtils.getInvokeType(params);
		String listStyle = DirectiveUtils.getString(PARAM_STYLE_LIST, params);
		if (InvokeType.sysDefined == type) {
			if (StringUtils.isBlank(listStyle)) {
				throw new ParamsRequiredException(PARAM_STYLE_LIST);
			}
			env.include(TPL_STYLE_LIST + listStyle + TPL_SUFFIX, UTF8, true);
			FrontUtils.includePagination(site, params, env);
		} else if (InvokeType.userDefined == type) {
			if (StringUtils.isBlank(listStyle)) {
				throw new ParamsRequiredException(PARAM_STYLE_LIST);
			}
			FrontUtils.includeTpl(TPL_STYLE_LIST, site, env);
			FrontUtils.includePagination(site, params, env);
		} else if (InvokeType.custom == type) {
			FrontUtils.includeTpl(TPL_NAME, site, params, env);
			FrontUtils.includePagination(site, params, env);
		} else if (InvokeType.body == type) {
			body.render(env.getOut());
			FrontUtils.includePagination(site, params, env);
		} else {
			throw new RuntimeException("invoke type not handled: " + type);
		}
		DirectiveUtils.removeParamsFromVariable(env, paramWrap, origMap);
	}

	
	private Pagination convert(SolrResult sr) {
		Pagination page = new Pagination(sr.getPageNo(), sr.getPageSize(), sr.getTotalCount());
		List<Content> resultList = new ArrayList<Content>();
		Map<String, Object> resultMap = sr.getResultMap();
		List<Map<String, Object>> list =  (List<Map<String, Object>>) resultMap.get(SolrResult.RESULT_LIST);
		Integer[] ids = new Integer[sr.getPageSize()];
		
		for(int i=0; i<list.size(); i++) {
			Map<String, Object> map = list.get(i);
			String id = (String) map.get("ID");
			ids[i] = Integer.parseInt(id);
		}
		
		if(ids.length > 0) {
			resultList = contentMng.getListByIdsForTag(ids, 4);
		}
		page.setList(resultList);
		return page;
	}

}
