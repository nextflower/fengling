package com.fengling.core.manager;

import java.util.Date;

import com.fengling.core.entity.CmsConfig;
import com.fengling.core.entity.CmsConfigAttr;
import com.fengling.core.entity.MarkConfig;
import com.fengling.core.entity.MemberConfig;

public interface CmsConfigMng {
	public CmsConfig get();

	public void updateCountCopyTime(Date d);

	public void updateCountClearTime(Date d);

	public CmsConfig update(CmsConfig bean);

	public MarkConfig updateMarkConfig(MarkConfig mark);

	public void updateMemberConfig(MemberConfig memberConfig);
	
	public void updateConfigAttr(CmsConfigAttr configAttr);
}