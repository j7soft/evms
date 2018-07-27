﻿/**
 * Smart Editor Basic
 * 
 * @version 0.3.13
 */
if (typeof window.nhn == 'undefined')
	window.nhn = {};
nhn.DOMFix = new ($Class({
	$init : function() {
		if ($Agent().navigator().ie || $Agent().navigator().opera) {
			this.childNodes = this._childNodes_Fix;
			this.parentNode = this._parentNode_Fix;
		} else {
			this.childNodes = this._childNodes_Native;
			this.parentNode = this._parentNode_Native;
		}
	},
	_parentNode_Native : function(elNode) {
		return elNode.parentNode;
	},
	_parentNode_Fix : function(elNode) {
		if (!elNode)
			return elNode;
		while (elNode.previousSibling) {
			elNode = elNode.previousSibling;
		}
		return elNode.parentNode;
	},
	_childNodes_Native : function(elNode) {
		return elNode.childNodes;
	},
	_childNodes_Fix : function(elNode) {
		var aResult = null;
		var nCount = 0;
		if (elNode) {
			var aResult = [];
			elNode = elNode.firstChild;
			while (elNode) {
				aResult[nCount++] = elNode;
				elNode = elNode.nextSibling;
			}
		}
		return aResult;
	}
}))();
if (typeof window.nhn == 'undefined')
	window.nhn = {};
if (!nhn.husky)
	nhn.husky = {};
nhn.husky.HuskyCore = $Class({
	name : "HuskyCore",
	plugins : null,
	aOrderedPlugins : null,
	oCommandMap : null,
	oDisabledCommand : null,
	commandQueue : [],
	$init : function() {
		this.plugins = {};
		this.oCommandMap = {};
		this.oDisabledCommand = {};
		this.aOrderedPlugins = [];
		this.oAgentInfo = $Agent();
		this.oNavigatorInfo = this.oAgentInfo.navigator();
		this.appStatus = nhn.husky.APP_STATUS["NOT_READY"];
		this.registerPlugin(this);
	},
	exec : function(cmd, args, oEvent) {
		if (this.appStatus == nhn.husky.APP_STATUS["NOT_READY"]
				&& cmd != "CHANGE_APP_STATUS") {
			this._queueAppCommand(cmd, args, oEvent);
			return true;
		}
		this.exec = this._exec;
		this.exec(cmd, args, oEvent);
	},
	delayedExec : function(cmd, args, nDelay, oEvent) {
		var fExec = $Fn(this.exec, this).bind(cmd, args, oEvent);
		setTimeout(fExec, nDelay);
	},
	_exec : function(cmd, args, oEvent) {
		if (this.oDisabledCommand[cmd])
			return false;
		var allArgs = [];
		if (args && args.length) {
			var iLen = args.length;
			for (var i = 0; i < iLen; i++)
				allArgs[i] = args[i];
		}
		if (oEvent)
			allArgs[allArgs.length] = oEvent;
		var bContinue = true;
		bContinue = this._execAppCommand("$BEFORE_" + cmd, allArgs);
		if (bContinue)
			bContinue = this._execAppCommand("$ON_" + cmd, allArgs);
		if (bContinue)
			bContinue = this._execAppCommand("$AFTER_" + cmd, allArgs);
		return bContinue;
	},
	registerPlugin : function(oPlugin) {
		if (!oPlugin)
			throw ("Invalid plugin cannot be registered");
		if (!oPlugin.name)
			throw ("Plugin.name is required");
		var bSupportedBrowser = true;
		if (oPlugin.supportedBrowser) {
			bSupportedBrowser = false;
			for (var i = 0; i < oPlugin.supportedBrowser.length; i++) {
				if (this.oNavigatorInfo[oPlugin.supportedBrowser[i]]) {
					bSupportedBrowser = true;
					break;
				}
			}
			if (!bSupportedBrowser) {
				this.exec("MSG_PLUGIN_REJECTED", [ oPlugin ]);
				return;
			}
		}
		if (oPlugin.unsupportedBrowser) {
			for (var i = 0; i < oPlugin.unsupportedBrowser.length; i++) {
				if (this.oNavigatorInfo[oPlugin.unsupportedBrowser[i]]) {
					this.exec("MSG_PLUGIN_REJECTED", [ oPlugin ]);
					return;
				}
			}
		}
		this.plugins[oPlugin.name] = oPlugin;
		this.aOrderedPlugins[this.aOrderedPlugins.length] = oPlugin;
		oPlugin.oApp = this;
		if (oPlugin.status != nhn.husky.PLUGIN_STATUS["NOT_READY"])
			oPlugin.status = nhn.husky.PLUGIN_STATUS["READY"];
		this.exec("MSG_PLUGIN_REGISTERED", [ oPlugin ]);
	},
	registerBrowserEvent : function(obj, sEvent, sCMD, aParams) {
		aParams = aParams || [];
		var func = $Fn(this.exec, this).bind(sCMD, aParams);
		$Fn(func, this).attach(obj, sEvent);
	},
	stopBrowserEvent : function(obj, sEvent) {
		$Fn(function(we) {
			we.stop();
		}, this).attach(obj, sEvent);
	},
	run : function(funcOnReady) {
		this.exec("CHANGE_APP_STATUS",
				[ nhn.husky.APP_STATUS["WAITING_FOR_PLUGIN_READY"] ]);
		for ( var x in this.plugins) {
			if (this.plugins[x].requiredPlugin) {
				for ( var y in this.plugins[x].requiredPlugin) {
					if (!this.plugins[this.plugins[x].requiredPlugin[y]]) {
						var sMsg = this.plugins[x].name + " requires "
								+ this.plugins[x].requiredPlugin[y] + " plugin";
						throw (sMsg);
					}
				}
			}
		}
		var iQueueLength = this.commandQueue.length;
		for (i = 0; i < iQueueLength; i++) {
			var curCmdAndArgs = this.commandQueue[i];
			this.exec(curCmdAndArgs.cmd, curCmdAndArgs.args,
					curCmdAndArgs.event);
		}
		this._waitForPluginReady(funcOnReady);
	},
	$ON_ADD_APP_PROPERTY : function(sPropertyName, oProperty) {
		this[sPropertyName] = oProperty;
	},
	$ON_CHANGE_APP_STATUS : function(appStatus, funcOnReady) {
		this.appStatus = appStatus;
		if (this.appStatus == nhn.husky.APP_STATUS["READY"])
			this.exec("MSG_APP_READY", [ funcOnReady ]);
	},
	$AFTER_MSG_APP_READY : function(funcOnReady) {
		this.oApp.exec("EXEC_INITIALIZER", [ funcOnReady ]);
	},
	$ON_DISABLE_COMMAND : function(sCommand) {
		this.oDisabledCommand[sCommand] = true;
	},
	$ON_ENABLE_COMMAND : function(sCommand) {
		this.oDisabledCommand[sCommand] = false;
	},
	$ON_EXEC_INITIALIZER : function(funcOnReady) {
		if (typeof funcOnReady == "function")
			funcOnReady();
	},
	_execAppCommand : function(sCmdHandler, args) {
		if (!this.oCommandMap[sCmdHandler]) {
			this.createCommandMap(sCmdHandler);
		}
		var aPlugins = this.oCommandMap[sCmdHandler];
		var iNumOfPlugins = aPlugins.length;
		var tmpStatus;
		if (sCmdHandler.match(/^\$(BEFORE|ON|AFTER)_MSG_APP_READY$/)) {
			for (var i = 0; i < iNumOfPlugins; i++) {
				tmpStatus = aPlugins[i][sCmdHandler].apply(aPlugins[i], args);
				if (tmpStatus === false)
					return false;
			}
		} else {
			for (var i = 0; i < iNumOfPlugins; i++) {
				if (typeof aPlugins[i]["$PRECONDITION"] == "function")
					if (!aPlugins[i]["$PRECONDITION"].call(aPlugins[i],
							sCmdHandler, args))
						continue;
				tmpStatus = aPlugins[i][sCmdHandler].apply(aPlugins[i], args);
				if (tmpStatus === false)
					return false;
			}
		}
		return true;
	},
	createCommandMap : function(sCmdHandler) {
		this.oCommandMap[sCmdHandler] = [];
		var nLen = this.aOrderedPlugins.length;
		var oPlugin;
		for (var i = 0; i < nLen; i++) {
			oPlugin = this.aOrderedPlugins[i];
			if (typeof oPlugin[sCmdHandler] == "function")
				this.oCommandMap[sCmdHandler][this.oCommandMap[sCmdHandler].length] = oPlugin;
		}
	},
	_queueAppCommand : function(cmd, args, oEvent) {
		this.commandQueue[this.commandQueue.length] = {
			'cmd' : cmd,
			'args' : args,
			'event' : oEvent
		};
	},
	_waitForPluginReady : function(funcOnReady) {
		var bAllReady = true;
		for (x in this.plugins) {
			if (this.plugins[x].status == nhn.husky.PLUGIN_STATUS["NOT_READY"]) {
				bAllReady = false;
				break;
			}
		}
		if (bAllReady) {
			this.exec("CHANGE_APP_STATUS", [ nhn.husky.APP_STATUS["READY"],
					funcOnReady ]);
		} else {
			setTimeout($Fn(this._waitForPluginReady, this).bind(funcOnReady),
					100);
		}
	}
});
nhn.husky.APP_STATUS = {
	'NOT_READY' : 0,
	'WAITING_FOR_PLUGIN_READY' : 1,
	'READY' : 2
};
nhn.husky.PLUGIN_STATUS = {
	'NOT_READY' : 0,
	'READY' : 1
};
if (typeof window.nhn == 'undefined')
	window.nhn = {};
nhn.W3CDOMRange = $Class({
	$init : function(doc) {
		this._document = doc || document;
		this.collapsed = true;
		this.commonAncestorContainer = this._document.body;
		this.endContainer = this._document.body;
		this.endOffset = 0;
		this.startContainer = this._document.body;
		this.startOffset = 0;
	},
	cloneContents : function() {
		var oClonedContents = this._document.createDocumentFragment();
		var oTmpContainer = this._document.createDocumentFragment();
		var aNodes = this._getNodesInRange();
		if (aNodes.length < 1)
			return oClonedContents;
		var oClonedContainers = this
				._constructClonedTree(aNodes, oTmpContainer);
		var oTopContainer = oTmpContainer.firstChild;
		if (oTopContainer) {
			var elCurNode = oTopContainer.firstChild;
			var elNextNode;
			while (elCurNode) {
				elNextNode = elCurNode.nextSibling;
				oClonedContents.appendChild(elCurNode);
				elCurNode = elNextNode;
			}
		}
		oClonedContainers = this._splitTextEndNodes({
			oStartContainer : oClonedContainers.oStartContainer,
			iStartOffset : this.startOffset,
			oEndContainer : oClonedContainers.oEndContainer,
			iEndOffset : this.endOffset
		});
		if (oClonedContainers.oStartContainer
				&& oClonedContainers.oStartContainer.previousSibling)
			nhn.DOMFix.parentNode(oClonedContainers.oStartContainer)
					.removeChild(
							oClonedContainers.oStartContainer.previousSibling);
		if (oClonedContainers.oEndContainer
				&& oClonedContainers.oEndContainer.nextSibling)
			nhn.DOMFix.parentNode(oClonedContainers.oEndContainer).removeChild(
					oClonedContainers.oEndContainer.nextSibling);
		return oClonedContents;
	},
	_constructClonedTree : function(aNodes, oClonedParentNode) {
		var oClonedStartContainer = null;
		var oClonedEndContainer = null;
		var oStartContainer = this.startContainer;
		var oEndContainer = this.endContainer;
		_recurConstructClonedTree = function(aAllNodes, iCurIdx, oParentNode,
				oClonedParentNode) {
			if (iCurIdx < 0)
				return iCurIdx;
			var iChildIdx = iCurIdx - 1;
			var oCurNodeCloneWithChildren = aAllNodes[iCurIdx].cloneNode(false);
			if (aAllNodes[iCurIdx] == oStartContainer)
				oClonedStartContainer = oCurNodeCloneWithChildren;
			if (aAllNodes[iCurIdx] == oEndContainer)
				oClonedEndContainer = oCurNodeCloneWithChildren;
			while (iChildIdx >= 0
					&& nhn.DOMFix.parentNode(aAllNodes[iChildIdx]) == aAllNodes[iCurIdx]) {
				iChildIdx = this._recurConstructClonedTree(aAllNodes,
						iChildIdx, aAllNodes[iCurIdx],
						oCurNodeCloneWithChildren, oClonedStartContainer,
						oClonedEndContainer);
			}
			oClonedParentNode.insertBefore(oCurNodeCloneWithChildren,
					oClonedParentNode.firstChild);
			return iChildIdx;
		};
		aNodes[aNodes.length] = nhn.DOMFix
				.parentNode(aNodes[aNodes.length - 1]);
		_recurConstructClonedTree(aNodes, aNodes.length - 1,
				aNodes[aNodes.length - 1], oClonedParentNode);
		return {
			oStartContainer : oClonedStartContainer,
			oEndContainer : oClonedEndContainer
		};
	},
	cloneRange : function() {
		return this._copyRange(new nhn.W3CDOMRange(this._document));
	},
	_copyRange : function(oClonedRange) {
		oClonedRange.collapsed = this.collapsed;
		oClonedRange.commonAncestorContainer = this.commonAncestorContainer;
		oClonedRange.endContainer = this.endContainer;
		oClonedRange.endOffset = this.endOffset;
		oClonedRange.startContainer = this.startContainer;
		oClonedRange.startOffset = this.startOffset;
		oClonedRange._document = this._document;
		return oClonedRange;
	},
	collapse : function(toStart) {
		if (toStart) {
			this.endContainer = this.startContainer;
			this.endOffset = this.startOffset;
		} else {
			this.startContainer = this.endContainer;
			this.startOffset = this.endOffset;
		}
		this._updateRangeInfo();
	},
	compareBoundaryPoints : function(how, sourceRange) {
		switch (how) {
		case nhn.W3CDOMRange.START_TO_START:
			return this._compareEndPoint(this.startContainer, this.startOffset,
					sourceRange.startContainer, sourceRange.startOffset);
		case nhn.W3CDOMRange.START_TO_END:
			return this._compareEndPoint(this.endContainer, this.endOffset,
					sourceRange.startContainer, sourceRange.startOffset);
		case nhn.W3CDOMRange.END_TO_END:
			return this._compareEndPoint(this.endContainer, this.endOffset,
					sourceRange.endContainer, sourceRange.endOffset);
		case nhn.W3CDOMRange.END_TO_START:
			return this._compareEndPoint(this.startContainer, this.startOffset,
					sourceRange.endContainer, sourceRange.endOffset);
		}
	},
	_findBody : function(oNode) {
		if (!oNode)
			return null;
		while (oNode) {
			if (oNode.tagName == "BODY")
				return oNode;
			oNode = nhn.DOMFix.parentNode(oNode);
		}
		return null;
	},
	_compareEndPoint : function(oContainerA, iOffsetA, oContainerB, iOffsetB) {
		var iIdxA, iIdxB;
		if (!oContainerA || this._findBody(oContainerA) != this._document.body) {
			oContainerA = this._document.body;
			iOffsetA = 0;
		}
		if (!oContainerB || this._findBody(oContainerB) != this._document.body) {
			oContainerB = this._document.body;
			iOffsetB = 0;
		}
		var compareIdx = function(iIdxA, iIdxB) {
			if (iIdxB == -1)
				iIdxB = iIdxA + 1;
			if (iIdxA < iIdxB)
				return -1;
			if (iIdxA == iIdxB)
				return 0;
			return 1;
		};
		var oCommonAncestor = this._getCommonAncestorContainer(oContainerA,
				oContainerB);
		var oNodeA = oContainerA;
		if (oNodeA != oCommonAncestor) {
			while ((oTmpNode = nhn.DOMFix.parentNode(oNodeA)) != oCommonAncestor) {
				oNodeA = oTmpNode;
			}
			iIdxA = this._getPosIdx(oNodeA) + 0.5;
		} else
			iIdxA = iOffsetA;
		var oNodeB = oContainerB;
		if (oNodeB != oCommonAncestor) {
			while ((oTmpNode = nhn.DOMFix.parentNode(oNodeB)) != oCommonAncestor) {
				oNodeB = oTmpNode;
			}
			iIdxB = this._getPosIdx(oNodeB) + 0.5;
		} else
			iIdxB = iOffsetB;
		return compareIdx(iIdxA, iIdxB);
	},
	_getCommonAncestorContainer : function(oNode1, oNode2) {
		var oComparingNode = oNode2;
		while (oNode1) {
			while (oComparingNode) {
				if (oNode1 == oComparingNode)
					return oNode1;
				oComparingNode = nhn.DOMFix.parentNode(oComparingNode);
			}
			oComparingNode = oNode2;
			oNode1 = nhn.DOMFix.parentNode(oNode1);
		}
		return this._document.body;
	},
	deleteContents : function() {
		if (this.collapsed)
			return;
		this._splitTextEndNodesOfTheRange();
		var aNodes = this._getNodesInRange();
		if (aNodes.length < 1)
			return;
		var oPrevNode = aNodes[0].previousSibling;
		while (oPrevNode && this._isBlankTextNode(oPrevNode))
			oPrevNode = oPrevNode.previousSibling;
		var oNewStartContainer, iNewOffset;
		if (!oPrevNode) {
			oNewStartContainer = nhn.DOMFix.parentNode(aNodes[0]);
			iNewOffset = 0;
		}
		for (var i = 0; i < aNodes.length; i++) {
			var oNode = aNodes[i];
			if (!oNode.firstChild) {
				if (oNewStartContainer == oNode) {
					iNewOffset = this._getPosIdx(oNewStartContainer);
					oNewStartContainer = nhn.DOMFix.parentNode(oNode);
				}
				nhn.DOMFix.parentNode(oNode).removeChild(oNode);
			}
		}
		if (!oPrevNode) {
			this.setStart(oNewStartContainer, iNewOffset);
		} else {
			if (oPrevNode.tagName == "BODY")
				this.setStartBefore(oPrevNode);
			else
				this.setStartAfter(oPrevNode);
		}
		this.collapse(true);
	},
	extractContents : function() {
		var oClonedContents = this.cloneContents();
		this.deleteContents();
		return oClonedContents;
	},
	insertNode : function(newNode) {
		var oFirstNode = null;
		var oParentContainer;
		if (this.startContainer.nodeType == "3") {
			oParentContainer = nhn.DOMFix.parentNode(this.startContainer);
			if (this.startContainer.nodeValue.length <= this.startOffset)
				oFirstNode = this.startContainer.nextSibling;
			else
				oFirstNode = this.startContainer.splitText(this.startOffset);
		} else {
			oParentContainer = this.startContainer;
			oFirstNode = nhn.DOMFix.childNodes(this.startContainer)[this.startOffset];
		}
		if (!oFirstNode || !nhn.DOMFix.parentNode(oFirstNode))
			oFirstNode = null;
		oParentContainer.insertBefore(newNode, oFirstNode);
		this.setStartBefore(newNode);
	},
	selectNode : function(refNode) {
		this.setStartBefore(refNode);
		this.setEndAfter(refNode);
	},
	selectNodeContents : function(refNode) {
		this.setStart(refNode, 0);
		this.setEnd(refNode, nhn.DOMFix.childNodes(refNode).length);
	},
	_endsNodeValidation : function(oNode, iOffset) {
		if (!oNode || this._findBody(oNode) != this._document.body)
			throw new Error(
					"INVALID_NODE_TYPE_ERR oNode is not part of current document");
		if (oNode.nodeType == 3) {
			if (iOffset > oNode.nodeValue.length)
				iOffset = oNode.nodeValue.length;
		} else {
			if (iOffset > nhn.DOMFix.childNodes(oNode).length)
				iOffset = nhn.DOMFix.childNodes(oNode).length;
		}
		return iOffset;
	},
	setEnd : function(refNode, offset) {
		offset = this._endsNodeValidation(refNode, offset);
		this.endContainer = refNode;
		this.endOffset = offset;
		if (!this.startContainer
				|| this._compareEndPoint(this.startContainer, this.startOffset,
						this.endContainer, this.endOffset) != -1)
			this.collapse(false);
		this._updateRangeInfo();
	},
	setEndAfter : function(refNode) {
		if (!refNode)
			throw new Error("INVALID_NODE_TYPE_ERR in setEndAfter");
		if (refNode.tagName == "BODY") {
			this.setEnd(refNode, nhn.DOMFix.childNodes(refNode).length);
			return;
		}
		this.setEnd(nhn.DOMFix.parentNode(refNode),
				this._getPosIdx(refNode) + 1);
	},
	setEndBefore : function(refNode) {
		if (!refNode)
			throw new Error("INVALID_NODE_TYPE_ERR in setEndBefore");
		if (refNode.tagName == "BODY") {
			this.setEnd(refNode, 0);
			return;
		}
		this.setEnd(nhn.DOMFix.parentNode(refNode), this._getPosIdx(refNode));
	},
	setStart : function(refNode, offset) {
		offset = this._endsNodeValidation(refNode, offset);
		this.startContainer = refNode;
		this.startOffset = offset;
		if (!this.endContainer
				|| this._compareEndPoint(this.startContainer, this.startOffset,
						this.endContainer, this.endOffset) != -1)
			this.collapse(true);
		this._updateRangeInfo();
	},
	setStartAfter : function(refNode) {
		if (!refNode)
			throw new Error("INVALID_NODE_TYPE_ERR in setStartAfter");
		if (refNode.tagName == "BODY") {
			this.setStart(refNode, nhn.DOMFix.childNodes(refNode).length);
			return;
		}
		this.setStart(nhn.DOMFix.parentNode(refNode),
				this._getPosIdx(refNode) + 1);
	},
	setStartBefore : function(refNode) {
		if (!refNode)
			throw new Error("INVALID_NODE_TYPE_ERR in setStartBefore");
		if (refNode.tagName == "BODY") {
			this.setStart(refNode, 0);
			return;
		}
		this.setStart(nhn.DOMFix.parentNode(refNode), this._getPosIdx(refNode));
	},
	surroundContents : function(newParent) {
		newParent.appendChild(this.extractContents());
		this.insertNode(newParent);
		this.selectNode(newParent);
	},
	toString : function() {
		var oTmpContainer = this._document.createElement("DIV");
		oTmpContainer.appendChild(this.cloneContents());
		return oTmpContainer.textContent || oTmpContainer.innerText || "";
	},
	_isBlankTextNode : function(oNode) {
		if (oNode.nodeType == 3 && oNode.nodeValue == "")
			return true;
		return false;
	},
	_getPosIdx : function(refNode) {
		var idx = 0;
		for (var node = refNode.previousSibling; node; node = node.previousSibling)
			idx++;
		return idx;
	},
	_updateRangeInfo : function() {
		if (!this.startContainer) {
			this.init(this._document);
			return;
		}
		this.collapsed = this._isCollapsed(this.startContainer,
				this.startOffset, this.endContainer, this.endOffset);
		this.commonAncestorContainer = this._getCommonAncestorContainer(
				this.startContainer, this.endContainer);
	},
	_isCollapsed : function(oStartContainer, iStartOffset, oEndContainer,
			iEndOffset) {
		var bCollapsed = false;
		if (oStartContainer == oEndContainer && iStartOffset == iEndOffset) {
			bCollapsed = true;
		} else {
			var oActualStartNode = this._getActualStartNode(oStartContainer,
					iStartOffset);
			var oActualEndNode = this._getActualEndNode(oEndContainer,
					iEndOffset);
			oActualStartNode = this._getNextNode(this
					._getPrevNode(oActualStartNode));
			oActualEndNode = this._getPrevNode(this
					._getNextNode(oActualEndNode));
			if (oActualStartNode
					&& oActualEndNode
					&& oActualEndNode.tagName != "BODY"
					&& (this._getNextNode(oActualEndNode) == oActualStartNode || (oActualEndNode == oActualStartNode && this
							._isBlankTextNode(oActualEndNode))))
				bCollapsed = true;
		}
		return bCollapsed;
	},
	_splitTextEndNodesOfTheRange : function() {
		var oEndPoints = this._splitTextEndNodes({
			oStartContainer : this.startContainer,
			iStartOffset : this.startOffset,
			oEndContainer : this.endContainer,
			iEndOffset : this.endOffset
		});
		this.startContainer = oEndPoints.oStartContainer;
		this.startOffset = oEndPoints.iStartOffset;
		this.endContainer = oEndPoints.oEndContainer;
		this.endOffset = oEndPoints.iEndOffset;
	},
	_splitTextEndNodes : function(oEndPoints) {
		oEndPoints = this._splitStartTextNode(oEndPoints);
		oEndPoints = this._splitEndTextNode(oEndPoints);
		return oEndPoints;
	},
	_splitStartTextNode : function(oEndPoints) {
		var oStartContainer = oEndPoints.oStartContainer;
		var iStartOffset = oEndPoints.iStartOffset;
		var oEndContainer = oEndPoints.oEndContainer;
		var iEndOffset = oEndPoints.iEndOffset;
		if (!oStartContainer)
			return oEndPoints;
		if (oStartContainer.nodeType != 3)
			return oEndPoints;
		if (iStartOffset == 0)
			return oEndPoints;
		if (oStartContainer.nodeValue.length <= iStartOffset)
			return oEndPoints;
		var oLastPart = oStartContainer.splitText(iStartOffset);
		if (oStartContainer == oEndContainer) {
			iEndOffset -= iStartOffset;
			oEndContainer = oLastPart;
		}
		oStartContainer = oLastPart;
		iStartOffset = 0;
		return {
			oStartContainer : oStartContainer,
			iStartOffset : iStartOffset,
			oEndContainer : oEndContainer,
			iEndOffset : iEndOffset
		};
	},
	_splitEndTextNode : function(oEndPoints) {
		var oStartContainer = oEndPoints.oStartContainer;
		var iStartOffset = oEndPoints.iStartOffset;
		var oEndContainer = oEndPoints.oEndContainer;
		var iEndOffset = oEndPoints.iEndOffset;
		if (!oEndContainer)
			return oEndPoints;
		if (oEndContainer.nodeType != 3)
			return oEndPoints;
		if (iEndOffset >= oEndContainer.nodeValue.length)
			return oEndPoints;
		if (iEndOffset == 0)
			return oEndPoints;
		oEndContainer.splitText(iEndOffset);
		return {
			oStartContainer : oStartContainer,
			iStartOffset : iStartOffset,
			oEndContainer : oEndContainer,
			iEndOffset : iEndOffset
		};
	},
	_getNodesInRange : function() {
		if (this.collapsed)
			return [];
		var oStartNode = this._getActualStartNode(this.startContainer,
				this.startOffset);
		var oEndNode = this
				._getActualEndNode(this.endContainer, this.endOffset);
		return this._getNodesBetween(oStartNode, oEndNode);
	},
	_getActualStartNode : function(oStartContainer, iStartOffset) {
		var oStartNode = oStartContainer;
		;
		if (oStartContainer.nodeType == 3) {
			if (iStartOffset >= oStartContainer.nodeValue.length) {
				oStartNode = this._getNextNode(oStartContainer);
				if (oStartNode.tagName == "BODY")
					oStartNode = null;
			} else {
				oStartNode = oStartContainer;
			}
		} else {
			if (iStartOffset < nhn.DOMFix.childNodes(oStartContainer).length) {
				oStartNode = nhn.DOMFix.childNodes(oStartContainer)[iStartOffset];
			} else {
				oStartNode = this._getNextNode(oStartContainer);
				if (oStartNode.tagName == "BODY")
					oStartNode = null;
			}
		}
		return oStartNode;
	},
	_getActualEndNode : function(oEndContainer, iEndOffset) {
		var oEndNode = oEndContainer;
		if (iEndOffset == 0) {
			oEndNode = this._getPrevNode(oEndContainer);
			if (oEndNode.tagName == "BODY")
				oEndNode = null;
		} else if (oEndContainer.nodeType == 3) {
			oEndNode = oEndContainer;
		} else {
			oEndNode = nhn.DOMFix.childNodes(oEndContainer)[iEndOffset - 1];
		}
		return oEndNode;
	},
	_getNextNode : function(oNode) {
		if (!oNode || oNode.tagName == "BODY")
			return this._document.body;
		if (oNode.nextSibling)
			return oNode.nextSibling;
		return this._getNextNode(nhn.DOMFix.parentNode(oNode));
	},
	_getPrevNode : function(oNode) {
		if (!oNode || oNode.tagName == "BODY")
			return this._document.body;
		if (oNode.previousSibling)
			return oNode.previousSibling;
		return this._getPrevNode(nhn.DOMFix.parentNode(oNode));
	},
	_getNodesBetween : function(oStartNode, oEndNode) {
		var aNodesBetween = [];
		if (!oStartNode || !oEndNode)
			return aNodesBetween;
		this._recurGetNextNodesUntil(oStartNode, oEndNode, aNodesBetween);
		return aNodesBetween;
	},
	_recurGetNextNodesUntil : function(oNode, oEndNode, aNodesBetween) {
		if (!oNode)
			return false;
		if (!this._recurGetChildNodesUntil(oNode, oEndNode, aNodesBetween))
			return false;
		var oNextToChk = oNode.nextSibling;
		while (!oNextToChk) {
			if (!nhn.DOMFix.parentNode(oNode))
				return false;
			oNode = nhn.DOMFix.parentNode(oNode);
			aNodesBetween[aNodesBetween.length] = oNode;
			if (oNode == oEndNode)
				return false;
			oNextToChk = oNode.nextSibling;
		}
		return this
				._recurGetNextNodesUntil(oNextToChk, oEndNode, aNodesBetween);
	},
	_recurGetChildNodesUntil : function(oNode, oEndNode, aNodesBetween) {
		if (!oNode)
			return false;
		var bEndFound = false;
		var oCurNode = oNode;
		if (oCurNode.firstChild) {
			oCurNode = oCurNode.firstChild;
			while (oCurNode) {
				if (!this._recurGetChildNodesUntil(oCurNode, oEndNode,
						aNodesBetween)) {
					bEndFound = true;
					break;
				}
				oCurNode = oCurNode.nextSibling;
			}
		}
		aNodesBetween[aNodesBetween.length] = oNode;
		if (bEndFound)
			return false;
		if (oNode == oEndNode)
			return false;
		return true;
	}
});
nhn.W3CDOMRange.START_TO_START = 0;
nhn.W3CDOMRange.START_TO_END = 1;
nhn.W3CDOMRange.END_TO_END = 2;
nhn.W3CDOMRange.END_TO_START = 3;
if (typeof window.nhn == 'undefined')
	window.nhn = {};
nhn.SimpleSelection = function(win) {
	this.init = function(win) {
		this._window = win || window;
		this._document = this._window.document;
	};
	this.init(win);
	var oAgentInfo = $Agent().navigator();
	if (oAgentInfo.ie)
		nhn.SimpleSelectionImpl_IE.apply(this);
	else
		nhn.SimpleSelectionImpl_FF.apply(this);
	this.selectRange = function(oRng) {
		this.selectNone();
		this.addRange(oRng);
	};
	this.selectionLoaded = true;
	if (!this._oSelection)
		this.selectionLoaded = false;
};
nhn.SimpleSelectionImpl_FF = function() {
	this._oSelection = this._window.getSelection();
	this.getRangeAt = function(iNum) {
		iNum = iNum || 0;
		try {
			var oFFRange = this._oSelection.getRangeAt(iNum);
		} catch (e) {
			return new nhn.W3CDOMRange(this._document);
		}
		return this._FFRange2W3CRange(oFFRange);
	};
	this.addRange = function(oW3CRange) {
		var oFFRange = this._W3CRange2FFRange(oW3CRange);
		this._oSelection.addRange(oFFRange);
	};
	this.selectNone = function() {
		this._oSelection.removeAllRanges();
	};
	this._FFRange2W3CRange = function(oFFRange) {
		var oW3CRange = new nhn.W3CDOMRange(this._document);
		oW3CRange.setStart(oFFRange.startContainer, oFFRange.startOffset);
		oW3CRange.setEnd(oFFRange.endContainer, oFFRange.endOffset);
		return oW3CRange;
	};
	this._W3CRange2FFRange = function(oW3CRange) {
		var oFFRange = this._document.createRange();
		oFFRange.setStart(oW3CRange.startContainer, oW3CRange.startOffset);
		oFFRange.setEnd(oW3CRange.endContainer, oW3CRange.endOffset);
		return oFFRange;
	};
};
nhn.SimpleSelectionImpl_IE = function() {
	this._oSelection = this._document.selection;
	this.getRangeAt = function(iNum) {
		iNum = iNum || 0;
		if (this._oSelection.type == "Control") {
			var oW3CRange = new nhn.W3CDOMRange(this._document);
			var oSelectedNode = this._oSelection.createRange().item(iNum);
			if (!oSelectedNode || oSelectedNode.ownerDocument != this._document)
				return oW3CRange;
			oW3CRange.selectNode(oSelectedNode);
			return oW3CRange;
		} else {
			this._document.body.focus();
			var oSelectedNode = this._oSelection.createRangeCollection().item(
					iNum).parentElement();
			if (!oSelectedNode || oSelectedNode.ownerDocument != this._document) {
				var oW3CRange = new nhn.W3CDOMRange(this._document);
				return oW3CRange;
			}
			return this._IERange2W3CRange(this._oSelection
					.createRangeCollection().item(iNum));
		}
	};
	this.addRange = function(oW3CRange) {
		var oIERange = this._W3CRange2IERange(oW3CRange);
		oIERange.select();
	};
	this.selectNone = function() {
		this._oSelection.empty();
	};
	this._W3CRange2IERange = function(oW3CRange) {
		var oStartIERange = this._getIERangeAt(oW3CRange.startContainer,
				oW3CRange.startOffset);
		var oEndIERange = this._getIERangeAt(oW3CRange.endContainer,
				oW3CRange.endOffset);
		oStartIERange.setEndPoint("EndToEnd", oEndIERange);
		return oStartIERange;
	};
	this._getIERangeAt = function(oW3CContainer, iW3COffset) {
		var oIERange = this._document.body.createTextRange();
		var oEndPointInfoForIERange = this._getSelectableNodeAndOffsetForIE(
				oW3CContainer, iW3COffset);
		var oSelectableNode = oEndPointInfoForIERange.oSelectableNodeForIE;
		var iIEOffset = oEndPointInfoForIERange.iOffsetForIE;
		oIERange.moveToElementText(oSelectableNode);
		oIERange.collapse(oEndPointInfoForIERange.bCollapseToStart);
		oIERange.moveStart("character", iIEOffset);
		return oIERange;
	};
	this._getSelectableNodeAndOffsetForIE = function(oW3CContainer, iW3COffset) {
		var oIERange = this._document.body.createTextRange();
		var oNonTextNode = null;
		var aChildNodes = null;
		var iNumOfLeftNodesToCount = 0;
		if (oW3CContainer.nodeType == 3) {
			oNonTextNode = nhn.DOMFix.parentNode(oW3CContainer);
			aChildNodes = nhn.DOMFix.childNodes(oNonTextNode);
			iNumOfLeftNodesToCount = aChildNodes.length;
		} else {
			oNonTextNode = oW3CContainer;
			aChildNodes = nhn.DOMFix.childNodes(oNonTextNode);
			iNumOfLeftNodesToCount = iW3COffset;
		}
		var oNodeTester = null;
		var iResultOffset = 0;
		var bCollapseToStart = true;
		for (var i = 0; i < iNumOfLeftNodesToCount; i++) {
			oNodeTester = aChildNodes[i];
			if (oNodeTester.nodeType == 3) {
				if (oNodeTester == oW3CContainer)
					break;
				iResultOffset += oNodeTester.nodeValue.length;
			} else {
				oIERange.moveToElementText(oNodeTester);
				oNonTextNode = oNodeTester;
				iResultOffset = 0;
				bCollapseToStart = false;
			}
		}
		if (oW3CContainer.nodeType == 3)
			iResultOffset += iW3COffset;
		return {
			oSelectableNodeForIE : oNonTextNode,
			iOffsetForIE : iResultOffset,
			bCollapseToStart : bCollapseToStart
		};
	};
	this._IERange2W3CRange = function(oIERange) {
		var oW3CRange = new nhn.W3CDOMRange(this._document);
		var oIEPointRange = null;
		var oPosition = null;
		oIEPointRange = oIERange.duplicate();
		oIEPointRange.collapse(true);
		oPosition = this._getW3CContainerAndOffset(oIEPointRange, true);
		oW3CRange.setStart(oPosition.oContainer, oPosition.iOffset);
		var oCollapsedChecker = oIERange.duplicate();
		oCollapsedChecker.collapse(true);
		if (oCollapsedChecker.isEqual(oIERange)) {
			oW3CRange.collapse(true);
		} else {
			oIEPointRange = oIERange.duplicate();
			oIEPointRange.collapse(false);
			oPosition = this._getW3CContainerAndOffset(oIEPointRange);
			oW3CRange.setEnd(oPosition.oContainer, oPosition.iOffset);
		}
		return oW3CRange;
	};
	this._getW3CContainerAndOffset = function(oIEPointRange, bStartPt) {
		var oRgOrigPoint = oIEPointRange;
		var oContainer = oRgOrigPoint.parentElement();
		var offset = -1;
		var oRgTester = this._document.body.createTextRange();
		var aChildNodes = nhn.DOMFix.childNodes(oContainer);
		var oPrevNonTextNode = null;
		var pointRangeIdx = 0;
		for (var i = 0; i < aChildNodes.length; i++) {
			if (aChildNodes[i].nodeType == 3)
				continue;
			oRgTester.moveToElementText(aChildNodes[i]);
			if (oRgTester.compareEndPoints("StartToStart", oIEPointRange) >= 0)
				break;
			oPrevNonTextNode = aChildNodes[i];
		}
		var pointRangeIdx = i;
		if (pointRangeIdx != 0 && aChildNodes[pointRangeIdx - 1].nodeType == 3) {
			var oRgTextStart = this._document.body.createTextRange();
			var oCurTextNode = null;
			if (oPrevNonTextNode) {
				oRgTextStart.moveToElementText(oPrevNonTextNode);
				oRgTextStart.collapse(false);
				oCurTextNode = oPrevNonTextNode.nextSibling;
			} else {
				oRgTextStart.moveToElementText(oContainer);
				oRgTextStart.collapse(true);
				oCurTextNode = oContainer.firstChild;
			}
			var oRgTextsUpToThePoint = oRgOrigPoint.duplicate();
			oRgTextsUpToThePoint.setEndPoint("StartToStart", oRgTextStart);
			var textCount = oRgTextsUpToThePoint.text.length
			while (textCount > oCurTextNode.nodeValue.length
					&& oCurTextNode.nextSibling) {
				textCount -= oCurTextNode.nodeValue.length;
				oCurTextNode = oCurTextNode.nextSibling;
			}
			var oTmp = oCurTextNode.nodeValue;
			if (bStartPt && oCurTextNode.nextSibling
					&& oCurTextNode.nextSibling.nodeType == 3
					&& textCount == oCurTextNode.nodeValue.length) {
				textCount -= oCurTextNode.nodeValue.length;
				oCurTextNode = oCurTextNode.nextSibling;
			}
			oContainer = oCurTextNode;
			offset = textCount;
		} else {
			oContainer = oRgOrigPoint.parentElement();
			offset = pointRangeIdx;
		}
		return {
			"oContainer" : oContainer,
			"iOffset" : offset
		};
	};
}
if (typeof window.nhn == 'undefined')
	window.nhn = {};
nhn.HuskyRange = $Class(
		{
			setWindow : function(win) {
				this._window = win;
				this._document = win.document;
			},
			$init : function(win) {
				this.HUSKY_BOOMARK_START_ID_PREFIX = "husky_bookmark_start_";
				this.HUSKY_BOOMARK_END_ID_PREFIX = "husky_bookmark_end_";
				this.sBlockElement = "P|DIV|LI|H[1-6]|PRE";
				this.sBlockContainer = "BODY|TABLE|TH|TR|TD|UL|OL|BLOCKQUOTE|FORM";
				this.rxBlockElement = new RegExp("^(" + this.sBlockElement
						+ ")$");
				this.rxBlockContainer = new RegExp("^(" + this.sBlockContainer
						+ ")$")
				this.rxLineBreaker = new RegExp("^(" + this.sBlockElement + "|"
						+ this.sBlockContainer + ")$")
				this.setWindow(win);
				this.oSimpleSelection = new nhn.SimpleSelection(this._window);
				this.selectionLoaded = this.oSimpleSelection.selectionLoaded;
				this.$super.$init(this._document);
			},
			select : function() {
				this.oSimpleSelection.selectRange(this);
			},
			setFromSelection : function(iNum) {
				this.setRange(this.oSimpleSelection.getRangeAt(iNum));
			},
			setRange : function(oW3CRange) {
				this.setStart(oW3CRange.startContainer, oW3CRange.startOffset);
				this.setEnd(oW3CRange.endContainer, oW3CRange.endOffset);
			},
			setEndNodes : function(oSNode, oENode) {
				this.setEndAfter(oENode);
				this.setStartBefore(oSNode);
			},
			splitTextAtBothEnds : function() {
				this._splitTextEndNodesOfTheRange();
			},
			getStartNode : function() {
				if (this.collapsed) {
					if (this.startContainer.nodeType == 3) {
						if (this.startOffset == 0)
							return null;
						if (this.startContainer.nodeValue.length <= this.startOffset)
							return null;
						return this.startContainer;
					}
					return null;
				}
				if (this.startContainer.nodeType == 3) {
					if (this.startOffset >= this.startContainer.nodeValue.length)
						return this._getNextNode(this.startContainer);
					return this.startContainer;
				} else {
					if (this.startOffset >= nhn.DOMFix
							.childNodes(this.startContainer).length)
						return this._getNextNode(this.startContainer);
					return nhn.DOMFix.childNodes(this.startContainer)[this.startOffset];
				}
			},
			getEndNode : function() {
				if (this.collapsed)
					return this.getStartNode();
				if (this.endContainer.nodeType == 3) {
					if (this.endOffset == 0)
						return this._getPrevNode(this.endContainer);
					return this.endContainer;
				} else {
					if (this.endOffset == 0)
						return this._getPrevNode(this.endContainer);
					return nhn.DOMFix.childNodes(this.endContainer)[this.endOffset - 1];
				}
			},
			getNodeAroundRange : function(bBefore, bStrict) {
				if (this.collapsed && this.startContainer
						&& this.startContainer.nodeType == 3)
					return this.startContainer;
				if (!this.collapsed
						|| (this.startContainer && this.startContainer.nodeType == 3))
					return this.getStartNode();
				var oBeforeRange, oAfterRange, oResult;
				if (this.startOffset >= nhn.DOMFix
						.childNodes(this.startContainer).length)
					oAfterRange = this._getNextNode(this.startContainer);
				else
					oAfterRange = nhn.DOMFix.childNodes(this.startContainer)[this.startOffset];
				if (this.endOffset == 0)
					oBeforeRange = this._getPrevNode(this.endContainer);
				else
					oBeforeRange = nhn.DOMFix.childNodes(this.endContainer)[this.endOffset - 1];
				if (bBefore) {
					oResult = oBeforeRange;
					if (!oResult && !bStrict)
						oResult = oAfterRange;
				} else {
					oResult = oAfterRange;
					if (!oResult && !bStrict)
						oResult = oBeforeRange;
				}
				return oResult;
			},
			_getXPath : function(elNode) {
				var sXPath = "";
				while (elNode && elNode.nodeType == 1) {
					sXPath = "/" + elNode.tagName + "["
							+ this._getPosIdx4XPath(elNode) + "]" + sXPath;
					elNode = nhn.DOMFix.parentNode(elNode);
				}
				return sXPath;
			},
			_getPosIdx4XPath : function(refNode) {
				var idx = 0;
				for (var node = refNode.previousSibling; node; node = node.previousSibling)
					if (node.tagName == refNode.tagName)
						idx++;
				return idx;
			},
			_evaluateXPath : function(sXPath, oDoc) {
				sXPath = sXPath.substring(1, sXPath.length - 1);
				var aXPath = sXPath.split(/\//);
				var elNode = oDoc.body;
				for (var i = 2; i < aXPath.length && elNode; i++) {
					aXPath[i].match(/([^\[]+)\[(\d+)/i);
					var sTagName = RegExp.$1;
					var nIdx = RegExp.$2;
					var aAllNodes = nhn.DOMFix.childNodes(elNode);
					var aNodes = [];
					var nLength = aAllNodes.length;
					var nCount = 0;
					for (var ii = 0; ii < nLength; ii++) {
						if (aAllNodes[ii].tagName == sTagName)
							aNodes[nCount++] = aAllNodes[ii];
					}
					if (aNodes.length < nIdx)
						elNode = null;
					else
						elNode = aNodes[nIdx];
				}
				return elNode;
			},
			_evaluateXPathBookmark : function(oBookmark) {
				var sXPath = oBookmark["sXPath"];
				var nTextNodeIdx = oBookmark["nTextNodeIdx"];
				var nOffset = oBookmark["nOffset"];
				var elContainer = this._evaluateXPath(sXPath, this._document);
				if (nTextNodeIdx > -1 && elContainer) {
					var aChildNodes = nhn.DOMFix.childNodes(elContainer);
					var elNode = null;
					var nIdx = nTextNodeIdx;
					var nOffsetLeft = nOffset;
					while ((elNode = aChildNodes[nIdx]) && elNode.nodeType == 3
							&& elNode.nodeValue.length < nOffsetLeft) {
						nOffsetLeft -= elNode.nodeValue.length;
						nIdx++;
					}
					elContainer = nhn.DOMFix.childNodes(elContainer)[nIdx];
					nOffset = nOffsetLeft;
				}
				if (!elContainer) {
					elContainer = this._document.body;
					nOffset = 0;
				}
				return {
					elContainer : elContainer,
					nOffset : nOffset
				};
			},
			getXPathBookmark : function() {
				var nTextNodeIdx1 = -1;
				var htEndPt1 = {
					elContainer : this.startContainer,
					nOffset : this.startOffset
				};
				var elNode1 = this.startContainer;
				if (elNode1.nodeType == 3) {
					htEndPt1 = this._getFixedStartTextNode();
					nTextNodeIdx1 = this._getPosIdx(htEndPt1.elContainer);
					elNode1 = nhn.DOMFix.parentNode(elNode1);
				}
				var sXPathNode1 = this._getXPath(elNode1);
				var oBookmark1 = {
					sXPath : sXPathNode1,
					nTextNodeIdx : nTextNodeIdx1,
					nOffset : htEndPt1.nOffset
				};
				var nTextNodeIdx2 = -1;
				var htEndPt2 = {
					elContainer : this.endContainer,
					nOffset : this.endOffset
				};
				var elNode2 = this.endContainer;
				if (elNode2.nodeType == 3) {
					htEndPt2 = this._getFixedEndTextNode();
					nTextNodeIdx2 = this._getPosIdx(htEndPt2.elContainer);
					elNode2 = nhn.DOMFix.parentNode(elNode2);
				}
				var sXPathNode2 = this._getXPath(elNode2);
				var oBookmark2 = {
					sXPath : sXPathNode2,
					nTextNodeIdx : nTextNodeIdx2,
					nOffset : htEndPt2.nOffset
				};
				return [ oBookmark1, oBookmark2 ];
			},
			moveToXPathBookmark : function(aBookmark) {
				if (!aBookmark)
					return;
				var oBookmarkInfo1 = this._evaluateXPathBookmark(aBookmark[0]);
				var oBookmarkInfo2 = this._evaluateXPathBookmark(aBookmark[1]);
				if (!oBookmarkInfo1["elContainer"]
						|| !oBookmarkInfo2["elContainer"])
					return;
				this.startContainer = oBookmarkInfo1["elContainer"];
				this.startOffset = oBookmarkInfo1["nOffset"];
				this.endContainer = oBookmarkInfo2["elContainer"];
				this.endOffset = oBookmarkInfo2["nOffset"];
			},
			_getFixedTextContainer : function(elNode, nOffset) {
				while (elNode && elNode.nodeType == 3 && elNode.previousSibling
						&& elNode.previousSibling.nodeType == 3) {
					nOffset += elNode.previousSibling.nodeValue.length;
					elNode = elNode.previousSibling;
				}
				return {
					elContainer : elNode,
					nOffset : nOffset
				};
			},
			_getFixedStartTextNode : function() {
				return this._getFixedTextContainer(this.startContainer,
						this.startOffset);
			},
			_getFixedEndTextNode : function() {
				return this._getFixedTextContainer(this.endContainer,
						this.endOffset);
			},
			placeStringBookmark : function() {
				var sTmpId = (new Date()).getTime();
				var oInsertionPoint = this.cloneRange();
				oInsertionPoint.collapseToEnd();
				var oEndMarker = this._document.createElement("A");
				oEndMarker.id = this.HUSKY_BOOMARK_END_ID_PREFIX + sTmpId;
				oInsertionPoint.insertNode(oEndMarker);
				var oInsertionPoint = this.cloneRange();
				oInsertionPoint.collapseToStart();
				var oStartMarker = this._document.createElement("A");
				oStartMarker.id = this.HUSKY_BOOMARK_START_ID_PREFIX + sTmpId;
				oInsertionPoint.insertNode(oStartMarker);
				this.moveToBookmark(sTmpId);
				return sTmpId;
			},
			cloneRange : function() {
				return this._copyRange(new nhn.HuskyRange(this._window));
			},
			moveToBookmark : function(vBookmark) {
				if (typeof (vBookmark) != "object")
					this.moveToStringBookmark(vBookmark);
				else
					this.moveToXPathBookmark(vBookmark);
			},
			moveToStringBookmark : function(sBookmarkID) {
				var oStartMarker = this._document
						.getElementById(this.HUSKY_BOOMARK_START_ID_PREFIX
								+ sBookmarkID);
				var oEndMarker = this._document
						.getElementById(this.HUSKY_BOOMARK_END_ID_PREFIX
								+ sBookmarkID);
				if (!oStartMarker || !oEndMarker)
					return;
				this.setEndBefore(oEndMarker);
				this.setStartAfter(oStartMarker);
			},
			removeStringBookmark : function(sBookmarkID) {
				var oStartMarker = this._document
						.getElementById(this.HUSKY_BOOMARK_START_ID_PREFIX
								+ sBookmarkID);
				var oEndMarker = this._document
						.getElementById(this.HUSKY_BOOMARK_END_ID_PREFIX
								+ sBookmarkID);
				if (oStartMarker)
					nhn.DOMFix.parentNode(oStartMarker).removeChild(
							oStartMarker);
				if (oEndMarker)
					nhn.DOMFix.parentNode(oEndMarker).removeChild(oEndMarker);
			},
			collapseToStart : function() {
				this.collapse(true);
			},
			collapseToEnd : function() {
				this.collapse(false);
			},
			createAndInsertNode : function(sTagName) {
				tmpNode = this._document.createElement(tagName);
				this.insertNode(tmpNode)
				return tmpNode
			},
			getNodes : function(bSplitTextEndNodes, fnFilter) {
				if (bSplitTextEndNodes)
					this._splitTextEndNodesOfTheRange();
				var aAllNodes = this._getNodesInRange();
				var aFilteredNodes = [];
				if (!fnFilter)
					return aAllNodes;
				for (var i = 0; i < aAllNodes.length; i++)
					if (fnFilter(aAllNodes[i]))
						aFilteredNodes[aFilteredNodes.length] = aAllNodes[i];
				return aFilteredNodes;
			},
			getTextNodes : function(bSplitTextEndNodes) {
				var txtFilter = function(oNode) {
					if (oNode.nodeType == 3 && oNode.nodeValue != "\n"
							&& oNode.nodeValue != "")
						return true;
					else
						return false;
				}
				return this.getNodes(bSplitTextEndNodes, txtFilter);
			},
			surroundContentsWithNewNode : function(sTagName) {
				var oNewParent = this._document.createElement(sTagName);
				this.surroundContents(oNewParent);
				return oNewParent;
			},
			isRangeinRange : function(oAnoterRange, bIncludePartlySelected) {
				var startToStart = this.compareBoundaryPoints(
						this.START_TO_START, oAnoterRange);
				var startToEnd = this.compareBoundaryPoints(this.START_TO_END,
						oAnoterRange);
				var endToStart = this.compareBoundaryPoints(this.END_TO_START,
						oAnoterRange);
				var endToEnd = this.compareBoundaryPoints(this.END_TO_END,
						oAnoterRange);
				if (startToStart <= 0 && endToEnd >= 0)
					return true;
				if (bIncludePartlyIncluded) {
					if (startToEnd == 1)
						return false;
					if (endToStart == -1)
						return false;
					return true;
				}
				return false;
			},
			isNodeInRange : function(oNode, bIncludePartlySelected,
					bContentOnly) {
				var oTmpRange = new nhn.HuskyRange(this._window);
				if (bContentOnly && oNode.firstChild) {
					oTmpRange.setStartBefore(oNode.firstChild);
					oTmpRange.setEndAfter(oNode.lastChild);
				} else {
					oTmpRange.selectNode(oNode);
				}
				return isRangeInRange(oTmpRange, bIncludePartlySelected);
			},
			pasteHTML : function(sHTML) {
				if (sHTML == "") {
					this.deleteContents();
					return;
				}
				var oTmpDiv = this._document.createElement("DIV");
				oTmpDiv.innerHTML = sHTML;
				var oFirstNode = oTmpDiv.firstChild;
				var oLastNode = oTmpDiv.lastChild;
				var clone = this.cloneRange();
				var sBM = clone.placeStringBookmark();
				while (oTmpDiv.lastChild)
					this.insertNode(oTmpDiv.lastChild);
				this.setEndNodes(oFirstNode, oLastNode);
				clone.moveToBookmark(sBM);
				clone.deleteContents();
				clone.removeStringBookmark(sBM);
			},
			toString : function() {
				this.toString = nhn.W3CDOMRange.prototype.toString;
				return this.toString();
			},
			toHTMLString : function() {
				var oTmpContainer = this._document.createElement("DIV");
				oTmpContainer.appendChild(this.cloneContents());
				return oTmpContainer.innerHTML;
			},
			findAncestorByTagName : function(sTagName) {
				var oNode = this.commonAncestorContainer;
				while (oNode && oNode.tagName != sTagName)
					oNode = nhn.DOMFix.parentNode(oNode);
				return oNode;
			},
			selectNodeContents : function(oNode) {
				if (!oNode)
					return;
				var oFirstNode = oNode.firstChild ? oNode.firstChild : oNode;
				var oLastNode = oNode.lastChild ? oNode.lastChild : oNode;
				if (oFirstNode.nodeType == 3)
					this.setStart(oFirstNode, 0);
				else
					this.setStartBefore(oFirstNode);
				if (oLastNode.nodeType == 3)
					this.setEnd(oLastNode, oLastNode.nodeValue.length);
				else
					this.setEndAfter(oLastNode);
			},
			styleRange : function(oStyle, oAttribute, sNewSpanMarker) {
				var aStyleParents = this._getStyleParentNodes(sNewSpanMarker);
				if (aStyleParents.length < 1)
					return;
				var sName, sValue;
				for (var i = 0; i < aStyleParents.length; i++) {
					for ( var x in oStyle) {
						sName = x;
						sValue = oStyle[sName];
						if (typeof sValue != "string")
							continue;
						aStyleParents[i].style[sName] = sValue;
					}
					if (!oAttribute)
						continue;
					for ( var x in oAttribute) {
						sName = x;
						sValue = oAttribute[sName];
						if (typeof sValue != "string")
							continue;
						if (sName == "class") {
							$Element(aStyleParents[i]).addClass(sValue);
						} else {
							aStyleParents[i].setAttribute(sName, sValue);
						}
					}
				}
				this.setStartBefore(aStyleParents[0]);
				this.setEndAfter(aStyleParents[aStyleParents.length - 1]);
			},
			_getStyleParentNodes : function(sNewSpanMarker) {
				this._splitTextEndNodesOfTheRange();
				var oSNode = this.getStartNode();
				var oENode = this.getEndNode();
				var aAllNodes = this._getNodesInRange();
				var aResult = [];
				var oNode, iStartRelPos, iEndRelPos, oSpan, iSIdx, iEIdx;
				var nInitialLength = aAllNodes.length;
				for (var i = 0; i < nInitialLength; i++) {
					oNode = aAllNodes[i];
					if (!oNode)
						continue;
					if (oNode.nodeType != 3)
						continue;
					if (oNode.nodeValue == "")
						continue;
					if (nhn.DOMFix.parentNode(oNode).tagName == "SPAN") {
						iSIdx = $A(aAllNodes).indexOf(
								this._getVeryFirstRealChild(nhn.DOMFix
										.parentNode(oNode.parentNode)));
						iEIdx = $A(aAllNodes).indexOf(
								this._getVeryLastRealChild(nhn.DOMFix
										.parentNode(oNode)));
						if (iSIdx != -1 && iEIdx != -1) {
							aResult[aResult.length] = nhn.DOMFix
									.parentNode(oNode);
							continue;
						}
					}
					oSpan = this._document.createElement("SPAN");
					nhn.DOMFix.parentNode(oNode).insertBefore(oSpan, oNode);
					oSpan.appendChild(oNode);
					aResult[aResult.length] = oSpan;
					aAllNodes[aAllNodes.length] = oSpan;
					if (sNewSpanMarker)
						oSpan.setAttribute(sNewSpanMarker, "true");
				}
				this.setStartBefore(oSNode);
				this.setEndAfter(oENode);
				return aResult;
			},
			_getVeryFirstChild : function(oNode) {
				if (oNode.firstChild)
					return this._getVeryFirstChild(oNode.firstChild);
				return oNode;
			},
			_getVeryLastChild : function(oNode) {
				if (oNode.lastChild)
					return this._getVeryLastChild(oNode.lastChild);
				return oNode;
			},
			_getFirstRealChild : function(oNode) {
				var oFirstNode = oNode.firstChild;
				while (oFirstNode && oFirstNode.nodeType == 3
						&& oFirstNode.nodeValue == "")
					oFirstNode = oFirstNode.nextSibling;
				return oFirstNode;
			},
			_getLastRealChild : function(oNode) {
				var oLastNode = oNode.lastChild;
				while (oLastNode && oLastNode.nodeType == 3
						&& oLastNode.nodeValue == "")
					oLastNode = oLastNode.previousSibling;
				return oLastNode;
			},
			_getVeryFirstRealChild : function(oNode) {
				var oFirstNode = this._getFirstRealChild(oNode);
				if (oFirstNode)
					return this._getVeryFirstRealChild(oFirstNode);
				return oNode;
			},
			_getVeryLastRealChild : function(oNode) {
				var oLastNode = this._getLastRealChild(oNode);
				if (oLastNode)
					return this._getVeryLastChild(oLastNode);
				return oNode;
			},
			_getLineStartInfo : function(node) {
				var frontEndFinal = null;
				var frontEnd = node;
				var lineBreaker = node;
				var bParentBreak = true;
				var rxLineBreaker = this.rxLineBreaker;
				function getLineStart(node) {
					if (!node)
						return;
					if (frontEndFinal)
						return;
					if (rxLineBreaker.test(node.tagName)) {
						lineBreaker = node;
						frontEndFinal = frontEnd;
						bParentBreak = true;
						return;
					} else {
						frontEnd = node;
					}
					getFrontEnd(node.previousSibling);
					if (frontEndFinal)
						return;
					getLineStart(nhn.DOMFix.parentNode(node));
				}
				function getFrontEnd(node) {
					if (!node)
						return;
					if (frontEndFinal)
						return;
					if (rxLineBreaker.test(node.tagName)) {
						lineBreaker = node;
						frontEndFinal = frontEnd;
						bParentBreak = false;
						return;
					}
					if (node.firstChild && node.tagName != "TABLE") {
						var curNode = node.lastChild;
						while (curNode && !frontEndFinal) {
							getFrontEnd(curNode);
							curNode = curNode.previousSibling;
						}
					} else {
						frontEnd = node;
					}
					if (!frontEndFinal) {
						getFrontEnd(node.previousSibling);
					}
				}
				getLineStart(node);
				return {
					oNode : frontEndFinal,
					oLineBreaker : lineBreaker,
					bParentBreak : bParentBreak
				};
			},
			_getLineEndInfo : function(node) {
				var backEndFinal = null;
				var backEnd = node;
				var lineBreaker = node;
				var bParentBreak = true;
				var rxLineBreaker = this.rxLineBreaker;
				function getLineEnd(node) {
					if (!node)
						return;
					if (backEndFinal)
						return;
					if (rxLineBreaker.test(node.tagName)) {
						lineBreaker = node;
						backEndFinal = backEnd;
						bParentBreak = true;
						return;
					} else {
						backEnd = node;
					}
					getBackEnd(node.nextSibling);
					if (backEndFinal)
						return;
					getLineEnd(nhn.DOMFix.parentNode(node));
				}
				function getBackEnd(node) {
					if (!node)
						return;
					if (backEndFinal)
						return;
					if (rxLineBreaker.test(node.tagName)) {
						lineBreaker = node;
						backEndFinal = backEnd;
						bParentBreak = false;
						return;
					}
					if (node.firstChild && node.tagName != "TABLE") {
						var curNode = node.firstChild;
						while (curNode && !backEndFinal) {
							getBackEnd(curNode);
							curNode = curNode.nextSibling;
						}
					} else {
						backEnd = node;
					}
					if (!backEndFinal) {
						getBackEnd(node.nextSibling);
					}
				}
				getLineEnd(node);
				return {
					oNode : backEndFinal,
					oLineBreaker : lineBreaker,
					bParentBreak : bParentBreak
				};
			},
			getLineInfo : function() {
				var oSNode = this.getStartNode();
				var oENode = this.getEndNode();
				if (!oSNode)
					oSNode = this.getNodeAroundRange(true, true);
				if (!oENode)
					oENode = this.getNodeAroundRange(true, true);
				var oStart = this._getLineStartInfo(oSNode);
				var oStartNode = oStart.oNode;
				var oEnd = this._getLineEndInfo(oENode);
				var oEndNode = oEnd.oNode;
				var iRelativeStartPos = this._compareEndPoint(nhn.DOMFix
						.parentNode(oStartNode), this._getPosIdx(oStartNode),
						this.endContainer, this.endOffset);
				var iRelativeEndPos = this._compareEndPoint(nhn.DOMFix
						.parentNode(oEndNode), this._getPosIdx(oEndNode) + 1,
						this.startContainer, this.startOffset);
				if (!(iRelativeStartPos <= 0 && iRelativeEndPos >= 0)) {
					oSNode = this.getNodeAroundRange(false, true);
					oENode = this.getNodeAroundRange(false, true);
					oStart = this._getLineStartInfo(oSNode);
					oEnd = this._getLineEndInfo(oENode);
				}
				return {
					oStart : oStart,
					oEnd : oEnd
				};
			}
		}).extend(nhn.W3CDOMRange);
function Shortcut(sKey, sId) {
	var store = Shortcut.Store;
	var action = Shortcut.Action;
	if (typeof sId === "undefined" && sKey.constructor == String) {
		store.set("document", sKey, document);
		return action.init(store.get("document"), sKey);
	} else if (sId.constructor == String && sKey.constructor == String) {
		store.set(sId, sKey, $(sId));
		return action.init(store.get(sId), sKey);
	} else if (sId.constructor != String && sKey.constructor == String) {
		var fakeId = "nonID" + new Date().getTime();
		fakeId = Shortcut.Store.searchId(fakeId, sId);
		store.set(fakeId, sKey, sId);
		return action.init(store.get(fakeId), sKey);
	}
	alert(sId + unescape(" must be a String or null"));
};
Shortcut.Store = {
	anthorKeyHash : {},
	datas : {},
	currentId : "",
	currentKey : "",
	searchId : function(sId, oElement) {
		$H(this.datas).forEach(function(oValue, sKey) {
			if (oElement == oValue.element) {
				sId = sKey;
				$H.Break();
			}
		});
		return sId;
	},
	set : function(sId, sKey, oElement) {
		this.currentId = sId;
		this.currentKey = sKey;
		var idData = this.get(sId);
		this.datas[sId] = idData ? idData.createKey(sKey) : new Shortcut.Data(
				sId, sKey, oElement);
	},
	get : function(sId, sKey) {
		if (sKey) {
			return this.datas[sId].keys[sKey];
		} else {
			return this.datas[sId];
		}
	},
	reset : function(sId) {
		var data = this.datas[sId];
		Shortcut.Helper.bind(data.func, data.element, "detach");
		delete this.datas[sId];
	},
	allReset : function() {
		$H(this.datas).forEach($Fn(function(value, key) {
			this.reset(key);
		}, this).bind());
	}
};
Shortcut.Data = $Class({
	$init : function(sId, sKey, oElement) {
		this.id = sId;
		this.element = oElement;
		this.func = $Fn(this.fire, this);
		Shortcut.Helper.bind(this.func, oElement, "attach");
		this.keys = {};
		this.createKey(sKey);
	},
	createKey : function(sKey) {
		this.keys[sKey] = {};
		var data = this.keys[sKey];
		data.key = sKey;
		data.events = [];
		data.commonExceptions = [];
		data.keyAnalysis = Shortcut.Helper.keyInterpretor(sKey);
		data.stopDefalutBehavior = true;
		return this;
	},
	fire : function(weEvent) {
		$H(this.keys).forEach($Fn(function(value, key) {
			this.excute(weEvent, key);
		}, this).bind());
	},
	excute : function(weEvent, sRawKey) {
		var isExcute = true;
		var staticFun = Shortcut.Helper;
		var data = this.keys[sRawKey];
		if (staticFun.isCorrect(weEvent.key(), data.keyAnalysis)
				&& staticFun.notCommonException(weEvent, data.commonExceptions)) {
			$A(data.events).forEach(function(v) {
				if (data.stopDefalutBehavior) {
					var leng = v.exceptions.length;
					if (leng) {
						for (var i = 0; i < leng; i++) {
							if (!v.exception[i](weEvent)) {
								isExcute = false;
								break;
							}
						}
						if (isExcute) {
							v.event(weEvent);
							weEvent.stop();
						} else {
							$A.Break();
						}
					} else {
						v.event(weEvent);
						weEvent.stop();
					}
				}
			});
		}
	},
	addEvent : function(fpEvent, sRawKey) {
		var events = this.keys[sRawKey].events;
		if (!Shortcut.Helper.hasEvent(fpEvent, events)) {
			events.push({
				event : fpEvent,
				exceptions : []
			});
		}
		;
	},
	addException : function(fpException, sRawKey) {
		var commonExceptions = this.keys[sRawKey].commonExceptions;
		if (!Shortcut.Helper.hasException(fpException, commonExceptions)) {
			commonExceptions.push(fpException);
		}
		;
	},
	removeException : function(fpException, sRawKey) {
		var commonExceptions = this.keys[sRawKey].commonExceptions;
		commonExceptions = $A(commonExceptions).filter(function(exception) {
			return exception != fpException;
		}).$value();
	},
	removeEvent : function(fpEvent, sRawKey) {
		var events = this.keys[sRawKey].events;
		events = $A(events).filter(function(event) {
			return event != fpEvent;
		}).$value();
		this.unRegister(sRawKey);
	},
	unRegister : function(sRawKey) {
		var aEvents = this.keys[sRawKey].events;
		if (aEvents.length)
			delete this.keys[sRawKey];
		var hasNotKey = true;
		for ( var i in this.keys) {
			hasNotKey = false;
			break;
		}
		if (hasNotKey) {
			Shortcut.Helper.bind(this.func, this.element, "detach");
			delete Shortcut.Store.datas[this.id];
		}
	},
	startDefalutBehavior : function(sRawKey) {
		this._setDefalutBehavior(sRawKey, false);
	},
	stopDefalutBehavior : function(sRawKey) {
		this._setDefalutBehavior(sRawKey, true);
	},
	_setDefalutBehavior : function(sRawKey, bType) {
		this.keys[sRawKey].stopDefalutBehavior = bType;
	}
});
Shortcut.Helper = {
	keyInterpretor : function(sKey) {
		var keyArray = sKey.split("+");
		var wKeyArray = $A(keyArray);
		var returnVal = {};
		var specialKeys = {
			ctrl : false,
			shift : false,
			meta : false,
			alt : false
		};
		wKeyArray = wKeyArray.filter(function(v) {
			if (v == "ctrl" || v == "shift" || v == "meta" || v == "alt") {
				specialKeys[v] = true;
				return false;
			} else {
				return true;
			}
		});
		returnVal.specialKeys = specialKeys;
		var key = wKeyArray.$value()[0];
		if (key) {
			returnVal.keyCode = Shortcut.Store.anthorKeyHash[key]
					|| key.toLowerCase().charCodeAt(0);
		} else {
			returnVal.keyCode = false;
		}
		return returnVal;
	},
	isCorrect : function(oKey, keyAnalysis) {
		var specialKeys = keyAnalysis.specialKeys;
		var compareKeyCode = String.fromCharCode(oKey.keyCode).toLowerCase()
				.charCodeAt(0);
		if (oKey.shift == specialKeys.shift && oKey.ctrl == specialKeys.ctrl
				&& oKey.alt == specialKeys.alt
				&& !!oKey.meta == specialKeys.meta
				&& compareKeyCode == keyAnalysis.keyCode) {
			return true;
		}
		return false;
	},
	notCommonException : function(e, exceptions) {
		var leng = exceptions.length;
		for (var i = 0; i < leng; i++) {
			if (!exceptions[i](e))
				return false;
		}
		return true;
	},
	hasEvent : function(fpEvent, aEvents) {
		var nLength = aEvents.length;
		for (var i = 0; i < nLength; ++i) {
			if (this.aEvents.event == fpEvent) {
				return true;
			}
		}
		;
		return false;
	},
	hasException : function(fpException, commonExceptions) {
		var nLength = commonExceptions.length;
		for (var i = 0; i < nLength; ++i) {
			if (commonExceptions[i] == fpException) {
				return true;
			}
		}
		;
		return false;
	},
	bind : function(wfFunc, oElement, sType) {
		wfFunc[sType](oElement, "keydown");
	}
};
Shortcut.Action = {
	init : function(oData, sRawKey) {
		this.dataInstance = oData;
		this.rawKey = sRawKey;
		return this;
	},
	addEvent : function(fpEvent) {
		this.dataInstance.addEvent(fpEvent, this.rawKey);
		return this;
	},
	removeEvent : function(fpEvent) {
		this.dataInstance.removeEvent(fpEvent, this.rawKey);
		return this;
	},
	addException : function(fpException) {
		this.dataInstance.addException(fpException, this.rawKey);
		return this;
	},
	removeException : function(fpException) {
		this.dataInstance.removeException(fpException, this.rawKey);
		return this;
	},
	startDefalutBehavior : function() {
		this.dataInstance.startDefalutBehavior(this.rawKey);
		return this;
	},
	stopDefalutBehavior : function() {
		this.dataInstance.stopDefalutBehavior(this.rawKey);
		return this;
	},
	resetElement : function() {
		Shortcut.Store.reset(this.dataInstance.id);
		return this;
	},
	resetAll : function() {
		Shortcut.Store.allReset();
		return this;
	}
};
(function() {
	Shortcut.Store.anthorKeyHash = {
		backspace : 8,
		tab : 9,
		enter : 13,
		esc : 27,
		space : 32,
		pageup : 33,
		pagedown : 34,
		end : 35,
		home : 36,
		left : 37,
		up : 38,
		right : 39,
		down : 40,
		del : 46,
		comma : 188,
		period : 190,
		slash : 191
	};
	var hash = Shortcut.Store.anthorKeyHash;
	var agent = $Agent().navigator();
	if (agent.ie || agent.safari) {
		hash.hyphen = 189;
		hash.equal = 187;
	} else {
		hash.hyphen = 109;
		hash.equal = 61;
	}
})();
var shortcut = Shortcut;
var cssquery = (function() {
	var sVersion = '2.1.0';
	var debugOption = {
		repeat : 1
	};
	var UID = 1;
	var cost = 0;
	var validUID = {};
	var safeHTML = false;
	var getUID4HTML = function(oEl) {
		var nUID = safeHTML ? (oEl._cssquery_UID && oEl._cssquery_UID[0])
				: oEl._cssquery_UID;
		if (nUID && validUID[nUID] == oEl)
			return nUID;
		nUID = UID++;
		oEl._cssquery_UID = safeHTML ? [ nUID ] : nUID;
		validUID[nUID] = oEl;
		return nUID;
	};
	var getUID4XML = function(oEl) {
		var oAttr = oEl.getAttribute('_cssquery_UID');
		var nUID = safeHTML ? (oAttr && oAttr[0]) : oAttr;
		if (!nUID) {
			nUID = UID++;
			oEl.setAttribute('_cssquery_UID', safeHTML ? [ nUID ] : nUID);
		}
		return nUID;
	};
	var getUID = getUID4HTML;
	var uniqid = function(sPrefix) {
		return (sPrefix || '') + new Date().getTime()
				+ parseInt(Math.random() * 100000000);
	};
	var getChilds_dontShrink = function(oEl, sTagName) {
		if (sTagName == '*')
			return oEl.all || oEl.getElementsByTagName(sTagName);
		return oEl.getElementsByTagName(sTagName);
	};
	var clearKeys = function() {
		backupKeys._keys = {};
	};
	var oDocument_dontShrink = document;
	var bXMLDocument = false;
	var backupKeys = function(sQuery) {
		var oKeys = backupKeys._keys;
		sQuery = sQuery.replace(/'(\\'|[^'])*'/g, function(sAll) {
			var uid = uniqid('QUOT');
			oKeys[uid] = sAll;
			return uid;
		});
		sQuery = sQuery.replace(/"(\\"|[^"])*"/g, function(sAll) {
			var uid = uniqid('QUOT');
			oKeys[uid] = sAll;
			return uid;
		});
		sQuery = sQuery.replace(/\[(.*?)\]/g, function(sAll, sBody) {
			if (sBody.indexOf('ATTR') == 0)
				return sAll;
			var uid = '[' + uniqid('ATTR') + ']';
			oKeys[uid] = sAll;
			return uid;
		});
		var bChanged;
		do {
			bChanged = false;
			sQuery = sQuery.replace(/\(((\\\)|[^)|^(])*)\)/g, function(sAll,
					sBody) {
				if (sBody.indexOf('BRCE') == 0)
					return sAll;
				var uid = '_' + uniqid('BRCE');
				oKeys[uid] = sAll;
				bChanged = true;
				return uid;
			});
		} while (bChanged);
		return sQuery;
	};
	var restoreKeys = function(sQuery, bOnlyAttrBrace) {
		var oKeys = backupKeys._keys;
		var bChanged;
		var rRegex = bOnlyAttrBrace ? /(\[ATTR[0-9]+\])/g
				: /(QUOT[0-9]+|\[ATTR[0-9]+\])/g;
		do {
			bChanged = false;
			sQuery = sQuery.replace(rRegex, function(sKey) {
				if (oKeys[sKey]) {
					bChanged = true;
					return oKeys[sKey];
				}
				return sKey;
			});
		} while (bChanged);
		sQuery = sQuery.replace(/_BRCE[0-9]+/g, function(sKey) {
			return oKeys[sKey] ? oKeys[sKey] : sKey;
		});
		return sQuery;
	};
	var restoreString = function(sKey) {
		var oKeys = backupKeys._keys;
		var sOrg = oKeys[sKey];
		if (!sOrg)
			return sKey;
		return eval(sOrg);
	};
	var wrapQuot = function(sStr) {
		return '"' + sStr.replace(/"/g, '\\"') + '"';
	};
	var getStyleKey = function(sKey) {
		if (/^@/.test(sKey))
			return sKey.substr(1);
		return null;
	};
	var getCSS = function(oEl, sKey) {
		if (oEl.currentStyle) {
			if (sKey == "float")
				sKey = "styleFloat";
			return oEl.currentStyle[sKey] || oEl.style[sKey];
		} else if (window.getComputedStyle) {
			return oDocument_dontShrink.defaultView.getComputedStyle(oEl, null)
					.getPropertyValue(
							sKey.replace(/([A-Z])/g, "-$1").toLowerCase())
					|| oEl.style[sKey];
		}
		if (sKey == "float" && /MSIE/.test(window.navigator.userAgent))
			sKey = "styleFloat";
		return oEl.style[sKey];
	};
	var oCamels = {
		'accesskey' : 'accessKey',
		'cellspacing' : 'cellSpacing',
		'cellpadding' : 'cellPadding',
		'class' : 'className',
		'colspan' : 'colSpan',
		'for' : 'htmlFor',
		'maxlength' : 'maxLength',
		'readonly' : 'readOnly',
		'rowspan' : 'rowSpan',
		'tabindex' : 'tabIndex',
		'valign' : 'vAlign'
	};
	var getDefineCode = function(sKey) {
		var sVal;
		var sStyleKey;
		if (bXMLDocument) {
			sVal = 'oEl.getAttribute("' + sKey + '")';
		} else {
			if (sStyleKey = getStyleKey(sKey)) {
				sKey = '$$' + sStyleKey;
				sVal = 'getCSS(oEl, "' + sStyleKey + '")';
			} else {
				switch (sKey) {
				case 'checked':
					sVal = 'oEl.checked + ""';
					break;
				case 'disabled':
					sVal = 'oEl.disabled + ""';
					break;
				case 'enabled':
					sVal = '!oEl.disabled + ""';
					break;
				case 'readonly':
					sVal = 'oEl.readOnly + ""';
					break;
				case 'selected':
					sVal = 'oEl.selected + ""';
					break;
				default:
					if (oCamels[sKey])
						sVal = 'oEl.' + oCamels[sKey];
					else
						sVal = 'oEl.getAttribute("' + sKey + '")';
				}
			}
		}
		return '_' + sKey + ' = ' + sVal;
	};
	var getReturnCode = function(oExpr) {
		var sStyleKey = getStyleKey(oExpr.key);
		var sVar = '_' + (sStyleKey ? '$$' + sStyleKey : oExpr.key);
		var sVal = oExpr.val ? wrapQuot(oExpr.val) : '';
		switch (oExpr.op) {
		case '~=':
			return '(' + sVar + ' && (" " + ' + sVar + ' + " ").indexOf(" " + '
					+ sVal + ' + " ") > -1)';
		case '^=':
			return '(' + sVar + ' && ' + sVar + '.indexOf(' + sVal + ') == 0)';
		case '$=':
			return '(' + sVar + ' && ' + sVar + '.substr(' + sVar
					+ '.length - ' + oExpr.val.length + ') == ' + sVal + ')';
		case '*=':
			return '(' + sVar + ' && ' + sVar + '.indexOf(' + sVal + ') > -1)';
		case '!=':
			return '(' + sVar + ' != ' + sVal + ')';
		case '=':
			return '(' + sVar + ' == ' + sVal + ')';
		}
		return '(' + sVar + ')';
	};
	var getNodeIndex = function(oEl) {
		var nUID = getUID(oEl);
		var nIndex = oNodeIndexes[nUID] || 0;
		if (nIndex == 0) {
			for (var oSib = (oEl.parentNode || oEl._IE5_parentNode).firstChild; oSib; oSib = oSib.nextSibling) {
				if (oSib.nodeType != 1)
					continue;
				nIndex++;
				setNodeIndex(oSib, nIndex);
			}
			nIndex = oNodeIndexes[nUID];
		}
		return nIndex;
	};
	var oNodeIndexes = {};
	var setNodeIndex = function(oEl, nIndex) {
		var nUID = getUID(oEl);
		oNodeIndexes[nUID] = nIndex;
	};
	var unsetNodeIndexes = function() {
		setTimeout(function() {
			oNodeIndexes = {};
		}, 0);
	};
	var oPseudoes_dontShrink = {
		'contains' : function(oEl, sOption) {
			return (oEl.innerText || oEl.textContent || '').indexOf(sOption) > -1;
		},
		'last-child' : function(oEl, sOption) {
			for (oEl = oEl.nextSibling; oEl; oEl = oEl.nextSibling)
				if (oEl.nodeType == 1)
					return false;
			return true;
		},
		'first-child' : function(oEl, sOption) {
			for (oEl = oEl.previousSibling; oEl; oEl = oEl.previousSibling)
				if (oEl.nodeType == 1)
					return false;
			return true;
		},
		'only-child' : function(oEl, sOption) {
			var nChild = 0;
			for (var oChild = (oEl.parentNode || oEl._IE5_parentNode).firstChild; oChild; oChild = oChild.nextSibling) {
				if (oChild.nodeType == 1)
					nChild++;
				if (nChild > 1)
					return false;
			}
			return nChild ? true : false;
		},
		'empty' : function(oEl, _) {
			return oEl.firstChild ? false : true;
		},
		'nth-child' : function(oEl, nMul, nAdd) {
			var nIndex = getNodeIndex(oEl);
			return nIndex % nMul == nAdd;
		},
		'nth-last-child' : function(oEl, nMul, nAdd) {
			var oLast = (oEl.parentNode || oEl._IE5_parentNode).lastChild;
			for (; oLast; oLast = oLast.previousSibling)
				if (oLast.nodeType == 1)
					break;
			var nTotal = getNodeIndex(oLast);
			var nIndex = getNodeIndex(oEl);
			var nLastIndex = nTotal - nIndex + 1;
			return nLastIndex % nMul == nAdd;
		}
	};
	var getExpression = function(sBody) {
		var oRet = {
			defines : '',
			returns : 'true'
		};
		var sBody = restoreKeys(sBody, true);
		var aExprs = [];
		var aDefineCode = [], aReturnCode = [];
		var sId, sTagName;
		var sBody = sBody.replace(/:([\w-]+)(\(([^)]*)\))?/g, function(_,
				sType, _, sOption) {
			switch (sType) {
			case 'not':
				var oInner = getExpression(sOption);
				var sFuncDefines = oInner.defines;
				var sFuncReturns = oInner.returnsID + oInner.returnsTAG
						+ oInner.returns;
				aReturnCode.push('!(function() { ' + sFuncDefines + ' return '
						+ sFuncReturns + ' })()');
				break;
			case 'nth-child':
			case 'nth-last-child':
				sOption = restoreString(sOption);
				if (sOption == 'even')
					sOption = '2n';
				else if (sOption == 'odd')
					sOption = '2n+1';
				var nMul, nAdd;
				if (/([0-9]*)n([+-][0-9]+)*/.test(sOption)) {
					nMul = parseInt(RegExp.$1) || 1;
					nAdd = parseInt(RegExp.$2) || 0;
				} else {
					nMul = Infinity;
					nAdd = parseInt(sOption);
				}
				aReturnCode.push('oPseudoes_dontShrink[' + wrapQuot(sType)
						+ '](oEl, ' + nMul + ', ' + nAdd + ')');
				break;
			case 'first-of-type':
			case 'last-of-type':
				sType = (sType == 'first-of-type' ? 'nth-of-type'
						: 'nth-last-of-type');
				sOption = 1;
			case 'nth-of-type':
			case 'nth-last-of-type':
				sOption = restoreString(sOption);
				if (sOption == 'even')
					sOption = '2n';
				else if (sOption == 'odd')
					sOption = '2n+1';
				var nMul, nAdd;
				if (/([0-9]*)n([+-][0-9]+)*/.test(sOption)) {
					nMul = parseInt(RegExp.$1) || 1;
					nAdd = parseInt(RegExp.$2) || 0;
				} else {
					nMul = Infinity;
					nAdd = parseInt(sOption);
				}
				oRet.nth = [ nMul, nAdd, sType ];
				break;
			default:
				sOption = sOption ? restoreString(sOption) : '';
				aReturnCode.push('oPseudoes_dontShrink[' + wrapQuot(sType)
						+ '](oEl, ' + wrapQuot(sOption) + ')');
				break;
			}
			return '';
		});
		var sBody = sBody.replace(/\[(@?[\w-]+)(([!^~$*]?=)([^\]]*))?\]/g,
				function(_, sKey, _, sOp, sVal) {
					sKey = restoreString(sKey);
					sVal = restoreString(sVal);
					if (sKey == 'checked' || sKey == 'disabled'
							|| sKey == 'enabled' || sKey == 'readonly'
							|| sKey == 'selected') {
						if (!sVal) {
							sOp = '=';
							sVal = 'true';
						}
					}
					aExprs.push({
						key : sKey,
						op : sOp,
						val : sVal
					});
					return '';
				});
		var sBody = sBody.replace(/\.([\w-]+)/g, function(_, sClass) {
			aExprs.push({
				key : 'class',
				op : '~=',
				val : sClass
			});
			return '';
		});
		var sBody = sBody.replace(/#([\w-]+)/g, function(_, sIdValue) {
			if (bXMLDocument)
				aExprs.push({
					key : 'id',
					op : '=',
					val : sIdValue
				});
			else
				sId = sIdValue;
			return '';
		});
		sTagName = sBody == '*' ? '' : sBody;
		var oVars = {};
		for (var i = 0, oExpr; oExpr = aExprs[i]; i++) {
			var sKey = oExpr.key;
			if (!oVars[sKey])
				aDefineCode.push(getDefineCode(sKey));
			aReturnCode.unshift(getReturnCode(oExpr));
			oVars[sKey] = true;
		}
		if (aDefineCode.length)
			oRet.defines = 'var ' + aDefineCode.join(',') + ';';
		if (aReturnCode.length)
			oRet.returns = aReturnCode.join('&&');
		oRet.quotID = sId ? wrapQuot(sId) : '';
		oRet.quotTAG = sTagName ? wrapQuot(bXMLDocument ? sTagName : sTagName
				.toUpperCase()) : '';
		oRet.returnsID = sId ? 'oEl.id == ' + oRet.quotID + ' && ' : '';
		oRet.returnsTAG = sTagName && sTagName != '*' ? 'oEl.tagName == '
				+ oRet.quotTAG + ' && ' : '';
		return oRet;
	};
	var splitToParts = function(sQuery) {
		var aParts = [];
		var sRel = ' ';
		var sBody = sQuery.replace(/(.*?)\s*(!?[+>~ ]|!)\s*/g, function(_,
				sBody, sRelative) {
			if (sBody)
				aParts.push({
					rel : sRel,
					body : sBody
				});
			sRel = sRelative.replace(/\s+$/g, '') || ' ';
			return '';
		});
		if (sBody)
			aParts.push({
				rel : sRel,
				body : sBody
			});
		return aParts;
	};
	var isNth_dontShrink = function(oEl, sTagName, nMul, nAdd, sDirection) {
		var nIndex = 0;
		for (var oSib = oEl; oSib; oSib = oSib[sDirection])
			if (oSib.nodeType == 1 && (!sTagName || sTagName == oSib.tagName))
				nIndex++;
		return nIndex % nMul == nAdd;
	};
	var compileParts = function(aParts) {
		var aPartExprs = [];
		for (var i = 0, oPart; oPart = aParts[i]; i++)
			aPartExprs.push(getExpression(oPart.body));
		var sFunc = '';
		var sPushCode = 'aRet.push(oEl); if (oOptions.single) { bStop = true; }';
		for (var i = aParts.length - 1, oPart; oPart = aParts[i]; i--) {
			var oExpr = aPartExprs[i];
			var sPush = (debugOption.callback ? 'cost++;' : '') + oExpr.defines;
			var sReturn = 'if (bStop) {'
					+ (i == 0 ? 'return aRet;' : 'return;') + '}';
			if (oExpr.returns == 'true')
				sPush += (sFunc ? sFunc + '(oEl);' : sPushCode) + sReturn;
			else
				sPush += 'if (' + oExpr.returns + ') {'
						+ (sFunc ? sFunc + '(oEl);' : sPushCode) + sReturn
						+ '}';
			var sCheckTag = 'oEl.nodeType != 1';
			if (oExpr.quotTAG)
				sCheckTag = 'oEl.tagName != ' + oExpr.quotTAG;
			var sTmpFunc = '(function(oBase'
					+ (i == 0 ? ', oOptions) { var bStop = false; var aRet = [];'
							: ') {');
			if (oExpr.nth) {
				sPush = 'if (isNth_dontShrink(oEl, '
						+ (oExpr.quotTAG ? oExpr.quotTAG : 'false')
						+ ','
						+ oExpr.nth[0]
						+ ','
						+ oExpr.nth[1]
						+ ','
						+ '"'
						+ (oExpr.nth[2] == 'nth-of-type' ? 'previousSibling'
								: 'nextSibling') + '")) {' + sPush + '}';
			}
			switch (oPart.rel) {
			case ' ':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'var oCandi = oEl;'
							+ 'for (; oCandi; oCandi = (oCandi.parentNode || oCandi._IE5_parentNode)) {'
							+ 'if (oCandi == oBase) break;'
							+ '}'
							+ 'if (!oCandi || '
							+ sCheckTag
							+ ') return aRet;'
							+ sPush;
				} else {
					sTmpFunc += 'var aCandi = getChilds_dontShrink(oBase, '
							+ (oExpr.quotTAG || '"*"') + ');'
							+ 'for (var i = 0, oEl; oEl = aCandi[i]; i++) {'
							+ sPush + '}';
				}
				break;
			case '>':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'if ((oEl.parentNode || oEl._IE5_parentNode) != oBase || '
							+ sCheckTag + ') return aRet;' + sPush;
				} else {
					sTmpFunc += 'for (var oEl = oBase.firstChild; oEl; oEl = oEl.nextSibling) {'
							+ 'if ('
							+ sCheckTag
							+ ') { continue; }'
							+ sPush
							+ '}';
				}
				break;
			case '+':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'var oPrev;'
							+ 'for (oPrev = oEl.previousSibling; oPrev; oPrev = oPrev.previousSibling) { if (oPrev.nodeType == 1) break; }'
							+ 'if (!oPrev || oPrev != oBase || '
							+ sCheckTag
							+ ') return aRet;' + sPush;
				} else {
					sTmpFunc += 'for (var oEl = oBase.nextSibling; oEl; oEl = oEl.nextSibling) { if (oEl.nodeType == 1) break; }'
							+ 'if (!oEl || '
							+ sCheckTag
							+ ') { return aRet; }'
							+ sPush;
				}
				break;
			case '~':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'var oCandi = oEl;'
							+ 'for (; oCandi; oCandi = oCandi.previousSibling) { if (oCandi == oBase) break; }'
							+ 'if (!oCandi || '
							+ sCheckTag
							+ ') return aRet;'
							+ sPush;
				} else {
					sTmpFunc += 'for (var oEl = oBase.nextSibling; oEl; oEl = oEl.nextSibling) {'
							+ 'if ('
							+ sCheckTag
							+ ') { continue; }'
							+ 'if (!markElement_dontShrink(oEl, '
							+ i
							+ ')) { break; }' + sPush + '}';
				}
				break;
			case '!':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'for (; oBase; oBase = (oBase.parentNode || oBase._IE5_parentNode)) { if (oBase == oEl) break; }'
							+ 'if (!oBase || '
							+ sCheckTag
							+ ') return aRet;'
							+ sPush;
				} else {
					sTmpFunc += 'for (var oEl = (oBase.parentNode || oBase._IE5_parentNode); oEl; oEl = (oEl.parentNode || oEl._IE5_parentNode)) {'
							+ 'if ('
							+ sCheckTag
							+ ') { continue; }'
							+ sPush
							+ '}';
				}
				break;
			case '!>':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'var oRel = (oBase.parentNode || oBase._IE5_parentNode);'
							+ 'if (!oRel || oEl != oRel || ('
							+ sCheckTag
							+ ')) return aRet;' + sPush;
				} else {
					sTmpFunc += 'var oEl = (oBase.parentNode || oBase._IE5_parentNode);'
							+ 'if (!oEl || '
							+ sCheckTag
							+ ') { return aRet; }'
							+ sPush;
				}
				break;
			case '!+':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'var oRel;'
							+ 'for (oRel = oBase.previousSibling; oRel; oRel = oRel.previousSibling) { if (oRel.nodeType == 1) break; }'
							+ 'if (!oRel || oEl != oRel || ('
							+ sCheckTag
							+ ')) return aRet;' + sPush;
				} else {
					sTmpFunc += 'for (oEl = oBase.previousSibling; oEl; oEl = oEl.previousSibling) { if (oEl.nodeType == 1) break; }'
							+ 'if (!oEl || '
							+ sCheckTag
							+ ') { return aRet; }'
							+ sPush;
				}
				break;
			case '!~':
				if (oExpr.quotID) {
					sTmpFunc += 'var oEl = oDocument_dontShrink.getElementById('
							+ oExpr.quotID
							+ ');'
							+ 'var oRel;'
							+ 'for (oRel = oBase.previousSibling; oRel; oRel = oRel.previousSibling) { '
							+ 'if (oRel.nodeType != 1) { continue; }'
							+ 'if (oRel == oEl) { break; }'
							+ '}'
							+ 'if (!oRel || ('
							+ sCheckTag
							+ ')) return aRet;'
							+ sPush;
				} else {
					sTmpFunc += 'for (oEl = oBase.previousSibling; oEl; oEl = oEl.previousSibling) {'
							+ 'if ('
							+ sCheckTag
							+ ') { continue; }'
							+ 'if (!markElement_dontShrink(oEl, '
							+ i
							+ ')) { break; }' + sPush + '}';
				}
				break;
			}
			sTmpFunc += (i == 0 ? 'return aRet;' : '') + '})';
			sFunc = sTmpFunc;
		}
		eval('var fpCompiled = ' + sFunc + ';');
		return fpCompiled;
	};
	var parseQuery = function(sQuery) {
		var sCacheKey = sQuery;
		var fpSelf = arguments.callee;
		var fpFunction = fpSelf._cache[sCacheKey];
		if (!fpFunction) {
			sQuery = backupKeys(sQuery);
			var aParts = splitToParts(sQuery);
			fpFunction = fpSelf._cache[sCacheKey] = compileParts(aParts);
			fpFunction.depth = aParts.length;
		}
		return fpFunction;
	};
	parseQuery._cache = {};
	var parseTestQuery = function(sQuery) {
		var fpSelf = arguments.callee;
		var aSplitQuery = backupKeys(sQuery).split(/\s*,\s*/);
		var aResult = [];
		var nLen = aSplitQuery.length;
		var aFunc = [];
		for (var i = 0; i < nLen; i++) {
			aFunc.push((function(sQuery) {
				var sCacheKey = sQuery;
				var fpFunction = fpSelf._cache[sCacheKey];
				if (!fpFunction) {
					sQuery = backupKeys(sQuery);
					var oExpr = getExpression(sQuery);
					eval('fpFunction = function(oEl) { ' + oExpr.defines
							+ 'return (' + oExpr.returnsID + oExpr.returnsTAG
							+ oExpr.returns + '); };');
				}
				return fpFunction;
			})(restoreKeys(aSplitQuery[i])));
		}
		return aFunc;
	};
	parseTestQuery._cache = {};
	var distinct = function(aList) {
		var aDistinct = [];
		var oDummy = {};
		for (var i = 0, oEl; oEl = aList[i]; i++) {
			var nUID = getUID(oEl);
			if (oDummy[nUID])
				continue;
			aDistinct.push(oEl);
			oDummy[nUID] = true;
		}
		return aDistinct;
	};
	var markElement_dontShrink = function(oEl, nDepth) {
		var nUID = getUID(oEl);
		if (cssquery._marked[nDepth][nUID])
			return false;
		cssquery._marked[nDepth][nUID] = true;
		return true;
	};
	var oResultCache = null;
	var bUseResultCache = false;
	var cssquery = function(sQuery, oParent, oOptions) {
		if (typeof sQuery == 'object') {
			var oResult = {};
			for ( var k in sQuery)
				oResult[k] = arguments.callee(sQuery[k], oParent, oOptions);
			return oResult;
		}
		cost = 0;
		var executeTime = new Date().getTime();
		var aRet;
		for (var r = 0, rp = debugOption.repeat; r < rp; r++) {
			aRet = (function(sQuery, oParent, oOptions) {
				oOptions = oOptions || {};
				if (!oParent)
					oParent = document;
				oDocument_dontShrink = oParent.ownerDocument
						|| oParent.document || oParent;
				if (/\bMSIE\s([0-9]+(\.[0-9]+)*);/.test(navigator.userAgent)
						&& parseFloat(RegExp.$1) < 6) {
					try {
						oDocument_dontShrink.location;
					} catch (e) {
						oDocument_dontShrink = document;
					}
					oDocument_dontShrink.firstChild = oDocument_dontShrink
							.getElementsByTagName('html')[0];
					oDocument_dontShrink.firstChild._IE5_parentNode = oDocument_dontShrink;
				}
				bXMLDocument = (typeof XMLDocument != 'undefined') ? (oDocument_dontShrink.constructor === XMLDocument)
						: (!oDocument_dontShrink.location);
				getUID = bXMLDocument ? getUID4XML : getUID4HTML;
				clearKeys();
				var aSplitQuery = backupKeys(sQuery).split(/\s*,\s*/);
				var aResult = [];
				var nLen = aSplitQuery.length;
				for (var i = 0; i < nLen; i++)
					aSplitQuery[i] = restoreKeys(aSplitQuery[i]);
				for (var i = 0; i < nLen; i++) {
					var sSingleQuery = aSplitQuery[i];
					var aSingleQueryResult = null;
					var sResultCacheKey = sSingleQuery
							+ (oOptions.single ? '_single' : '');
					var aCache = bUseResultCache ? oResultCache[sResultCacheKey]
							: null;
					if (aCache) {
						for (var j = 0, oCache; oCache = aCache[j]; j++) {
							if (oCache.parent == oParent) {
								aSingleQueryResult = oCache.result;
								break;
							}
						}
					}
					if (!aSingleQueryResult) {
						var fpFunction = parseQuery(sSingleQuery);
						cssquery._marked = [];
						for (var j = 0, nDepth = fpFunction.depth; j < nDepth; j++)
							cssquery._marked.push({});
						aSingleQueryResult = distinct(fpFunction(oParent,
								oOptions));
						if (bUseResultCache) {
							if (!(oResultCache[sResultCacheKey] instanceof Array))
								oResultCache[sResultCacheKey] = [];
							oResultCache[sResultCacheKey].push({
								parent : oParent,
								result : aSingleQueryResult
							});
						}
					}
					aResult = aResult.concat(aSingleQueryResult);
				}
				unsetNodeIndexes();
				return aResult;
			})(sQuery, oParent, oOptions);
		}
		executeTime = new Date().getTime() - executeTime;
		if (debugOption.callback)
			debugOption.callback(sQuery, cost, executeTime);
		return aRet;
	};
	cssquery.test = function(oEl, sQuery) {
		clearKeys();
		var aFunc = parseTestQuery(sQuery);
		for (var i = 0, nLen = aFunc.length; i < nLen; i++)
			if (aFunc[i](oEl))
				return true;
		return false;
	};
	cssquery.useCache = function(bFlag) {
		if (typeof bFlag != 'undefined') {
			bUseResultCache = bFlag;
			cssquery.clearCache();
		}
		return bUseResultCache;
	};
	cssquery.clearCache = function() {
		oResultCache = {};
	};
	cssquery.getSingle = function(sQuery, oParent) {
		return cssquery(sQuery, oParent, {
			single : true
		})[0] || null;
	};
	cssquery.xpath = function(sXPath, oParent) {
		var sXPath = sXPath.replace(/\/(\w+)(\[([0-9]+)\])?/g, function(_,
				sTag, _, sTh) {
			sTh = sTh || '1';
			return '>' + sTag + ':nth-of-type(' + sTh + ')';
		});
		return cssquery.getSingle(sXPath, oParent);
	};
	cssquery.debug = function(fpCallback, nRepeat) {
		debugOption.callback = fpCallback;
		debugOption.repeat = nRepeat || 1;
	};
	cssquery.safeHTML = function(bFlag) {
		var bIE = /MSIE/.test(window.navigator.userAgent);
		if (arguments.length > 0)
			safeHTML = bFlag && bIE;
		return safeHTML || !bIE;
	};
	cssquery.version = sVersion;
	return cssquery;
})();
(function() {
	if (typeof $Element != 'undefined' && $Element.prototype
			&& '$value' in $Element.prototype) {
		$Element.prototype.queryAll = function(sQuery) {
			return cssquery(sQuery, this._element);
		};
		$Element.prototype.query = function(sQuery) {
			return cssquery.getSingle(sQuery, this._element);
		};
		$Element.prototype.test = function(sQuery) {
			return cssquery.test(this._element, sQuery);
		};
		$Element.prototype.xpathAll = function(sXpath) {
			return cssquery.xpath(sXpath, this._element);
		};
	}
	if (typeof $Document != 'undefined' && $Document.prototype) {
		$Document.prototype.queryAll = function(sQuery) {
			return cssquery(sQuery, this._document);
		};
		$Document.prototype.query = function(sQuery) {
			return cssquery.getSingle(sQuery, this._document);
		};
		$Document.prototype.xpathAll = function(sXpath) {
			return cssquery.xpath(sXpath, this._document);
		};
	}
})();
if (typeof window.nhn == 'undefined')
	window.nhn = {};
nhn.FindReplace = $Class({
	sKeyword : "",
	window : null,
	document : null,
	bBrowserSupported : false,
	bEOC : false,
	$init : function(win) {
		this.window = win;
		this.document = this.window.document;
		if (this.document.domain != this.document.location.hostname) {
			var oAgentInfo = $Agent();
			var oNavigatorInfo = oAgentInfo.navigator();
			if (oNavigatorInfo.firefox && oNavigatorInfo.version < 3) {
				this.bBrowserSupported = false;
				this.find = function() {
					return 3
				};
				return;
			}
		}
		this.bBrowserSupported = true;
	},
	find : function(sKeyword, bCaseMatch, bBackwards, bWholeWord) {
		var bSearchResult, bFreshSearch;
		this.window.focus();
		if (!sKeyword)
			return 2;
		this.bEOC = false;
		bSearchResult = this.findNext(sKeyword, bCaseMatch, bBackwards,
				bWholeWord);
		if (bSearchResult)
			return 0;
		this.bEOC = true;
		bSearchResult = this.findNew(sKeyword, bCaseMatch, bBackwards,
				bWholeWord);
		if (bSearchResult)
			return 0;
		return 1;
	},
	findNew : function(sKeyword, bCaseMatch, bBackwards, bWholeWord) {
		this.findReset();
		return this.findNext(sKeyword, bCaseMatch, bBackwards, bWholeWord);
	},
	findNext : function(sKeyword, bCaseMatch, bBackwards, bWholeWord) {
		var bSearchResult;
		bCaseMatch = bCaseMatch || false;
		bWholeWord = bWholeWord || false;
		bBackwards = bBackwards || false;
		if (this.window.find) {
			var bWrapAround = false;
			return this.window.find(sKeyword, bCaseMatch, bBackwards,
					bWrapAround, bWholeWord);
		}
		if (this.document.body.createTextRange) {
			var iOption = 0;
			if (bBackwards)
				iOption += 1;
			if (bWholeWord)
				iOption += 2;
			if (bCaseMatch)
				iOption += 4;
			this.window.focus();
			this._range = this.document.selection.createRangeCollection().item(
					0);
			this._range.collapse(false);
			bSearchResult = this._range.findText(sKeyword, 1, iOption);
			this._range.select();
			return bSearchResult;
		}
		return false;
	},
	findReset : function() {
		if (this.window.find) {
			this.window.getSelection().removeAllRanges();
			return;
		}
		if (this.document.body.createTextRange) {
			this._range = this.document.body.createTextRange();
			this._range.collapse(true);
			this._range.select();
		}
	},
	replace : function(sOriginalWord, Replacement, bCaseMatch, bBackwards,
			bWholeWord) {
		if (!sOriginalWord)
			return 4;
		var oSelection = new nhn.HuskyRange(this.window);
		oSelection.setFromSelection();
		bCaseMatch = bCaseMatch || false;
		var bMatch, selectedText = oSelection.toString();
		if (bCaseMatch)
			bMatch = (selectedText == sOriginalWord);
		else
			bMatch = (selectedText.toLowerCase() == sOriginalWord.toLowerCase());
		if (!bMatch)
			return this.find(sOriginalWord, bCaseMatch, bBackwards, bWholeWord) + 2;
		if (typeof Replacement == "function") {
			oSelection = Replacement(oSelection);
		} else {
			oSelection.pasteHTML(Replacement);
		}
		oSelection.collapseToEnd();
		oSelection.select();
		return this.find(sOriginalWord, bCaseMatch, bBackwards, bWholeWord);
	},
	replaceAll : function(sOriginalWord, Replacement, bCaseMatch, bWholeWord) {
		if (!sOriginalWord)
			return -1;
		var bBackwards = false;
		var iReplaceResult;
		var iResult = 0;
		var win = this.window;
		var oSelection = new nhn.HuskyRange(this.window);
		oSelection.setFromSelection();
		var sBookmark = oSelection.placeStringBookmark();
		this.bEOC = false;
		while (!this.bEOC) {
			iReplaceResult = this.replace(sOriginalWord, Replacement,
					bCaseMatch, bBackwards, bWholeWord);
			if (iReplaceResult == 0 || iReplaceResult == 1)
				iResult++;
		}
		var startingPointReached = function() {
			var oCurSelection = new nhn.HuskyRange(win);
			oCurSelection.setFromSelection();
			oSelection.moveToBookmark(sBookmark);
			var pos = oSelection.compareBoundaryPoints(
					nhn.W3CDOMRange.START_TO_END, oCurSelection);
			if (pos == 1)
				return false;
			return true;
		}
		iReplaceResult = 0;
		this.bEOC = false;
		while (!startingPointReached() && iReplaceResult == 0 && !this.bEOC) {
			iReplaceResult = this.replace(sOriginalWord, Replacement,
					bCaseMatch, bBackwards, bWholeWord);
			if (iReplaceResult == 0 || iReplaceResult == 1)
				iResult++;
		}
		oSelection.moveToBookmark(sBookmark);
		oSelection.select();
		oSelection.removeBookmark(sBookmark);
		return iResult;
	}
});
if (typeof window.nhn == 'undefined')
	window.nhn = {};
nhn.DraggableLayer = $Class({
	$init : function(oLayer, oOptions) {
		this.oOptions = $Class({}).extend({
			bModal : "false",
			oHandle : oLayer,
			iMinX : -999999,
			iMinY : -999999,
			iMaxX : 999999,
			iMaxY : 999999
		}).extend(oOptions);
		this.oHandle = this.oOptions.oHandle;
		oLayer.style.display = "block";
		oLayer.style.position = "absolute";
		oLayer.style.zIndex = "9999";
		this.aBasePosition = this.getBaseOffset(oLayer);
		oLayer.style.top = (this.toInt($Element(oLayer).offset().top) - this.aBasePosition.top)
				+ "px";
		oLayer.style.left = (this.toInt($Element(oLayer).offset().left) - this.aBasePosition.left)
				+ "px";
		this.$FnMouseDown = $Fn($Fn(this._mousedown, this).bind(oLayer), this);
		this.$FnMouseMove = $Fn($Fn(this._mousemove, this).bind(oLayer), this);
		this.$FnMouseUp = $Fn($Fn(this._mouseup, this).bind(oLayer), this);
		this.$FnMouseDown.attach(oLayer, "mousedown");
	},
	_mousedown : function(oLayer, oEvent) {
		if (oEvent.element.tagName == "INPUT")
			return;
		this.MouseOffsetY = (oEvent.pos().clientY
				- this.toInt(oLayer.style.top) - this.aBasePosition['top']);
		this.MouseOffsetX = (oEvent.pos().clientX
				- this.toInt(oLayer.style.left) - this.aBasePosition['left']);
		this.$FnMouseMove.attach(oLayer, "mousemove");
		this.$FnMouseUp.attach(oLayer, "mouseup");
	},
	_mousemove : function(oLayer, oEvent) {
		var iTop = (oEvent.pos().clientY - this.MouseOffsetY - this.aBasePosition['top']);
		var iLeft = (oEvent.pos().clientX - this.MouseOffsetX - this.aBasePosition['left']);
		if (iTop < this.oOptions.iMinY)
			iTop = this.oOptions.iMinY;
		if (iTop > this.oOptions.iMaxY)
			iTop = this.oOptions.iMaxY;
		if (iLeft < this.oOptions.iMinX)
			iLeft = this.oOptions.iMinX;
		if (iLeft > this.oOptions.iMaxX)
			iLeft = this.oOptions.iMaxX;
		oLayer.style.top = iTop + "px";
		oLayer.style.left = iLeft + "px";
	},
	_mouseup : function(oLayer, oEvent) {
		this.$FnMouseMove.detach(oLayer, "mousemove");
		this.$FnMouseUp.detach(oLayer, "mouseup");
	},
	toInt : function(num) {
		var result = parseInt(num);
		return result || 0;
	},
	findNonStatic : function(oEl) {
		if (!oEl)
			return oEl;
		if ($Element(oEl).css("position").match(/absolute|relative/i))
			return oEl;
		return this.findNonStatic(oEl.offsetParent);
	},
	getBaseOffset : function(oEl) {
		var oBase = this.findNonStatic(oEl.offsetParent);
		var tmp = $Element(oBase).offset();
		return {
			top : tmp.top,
			left : tmp.left
		};
	}
});
nhn.husky.Utils = $Class({
	name : "Utils",
	$init : function() {
		var oAgentInfo = $Agent();
		var oNavigatorInfo = oAgentInfo.navigator();
		if (oNavigatorInfo.ie && oNavigatorInfo.version == 6) {
			try {
				document.execCommand('BackgroundImageCache', false, true);
			} catch (e) {
			}
		}
	},
	$ON_ATTACH_HOVER_EVENTS : function(aElms, sHoverClass) {
		sHoverClass = sHoverClass || "hover";
		if (!aElms)
			return;
		var len = aElms.length;
		for (i = 0; i < len; i++) {
			var tmpElm = aElms[i];
			$Fn($Fn(function(tmpElm) {
				$Element(tmpElm).addClass(sHoverClass);
			}, this).bind(tmpElm), this).attach(tmpElm, "mouseover");
			$Fn($Fn(function(tmpElm) {
				$Element(tmpElm).removeClass(sHoverClass);
			}, this).bind(tmpElm), this).attach(tmpElm, "mouseout");
		}
	}
});
nhn.husky.HuskyRangeManager = $Class({
	name : "HuskyRangeManager",
	oWindow : null,
	$init : function(win) {
		this.oWindow = win || window;
	},
	$BEFORE_MSG_APP_READY : function() {
		if (this.oWindow && this.oWindow.tagName == "IFRAME")
			this.oWindow = this.oWindow.contentWindow;
		this.oApp.exec("ADD_APP_PROPERTY", [ "getSelection",
				$Fn(this.getSelection, this).bind() ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "getEmptySelection",
				$Fn(this.getEmptySelection, this).bind() ]);
	},
	$ON_SET_EDITING_WINDOW : function(oWindow) {
		this.oWindow = oWindow;
	},
	getEmptySelection : function() {
		var oHuskyRange = new nhn.HuskyRange(this.oWindow);
		return oHuskyRange;
	},
	getSelection : function() {
		var oHuskyRange = this.getEmptySelection();
		oHuskyRange.setFromSelection();
		return oHuskyRange;
	}
});
nhn.husky.Hotkey = $Class({
	name : "Hotkey",
	$init : function() {
		this.oShortcut = shortcut;
	},
	$ON_REGISTER_HOTKEY : function(sHotkey, sCMD, sArgs) {
		if (!sArgs)
			sArgs = [];
		var func = $Fn(this.oApp.exec, this.oApp).bind(sCMD, sArgs);
		this.oShortcut(sHotkey, this.oApp.getWYSIWYGDocument()).addEvent(func);
	}
});
nhn.husky.DialogLayerManager = $Class({
	name : "DialogLayerManager",
	aMadeDraggable : null,
	aOpenedLayers : null,
	$init : function() {
		this.aMadeDraggable = [];
		this.aOpenedLayers = [];
	},
	$ON_SHOW_DIALOG_LAYER : function(oLayer, bModal) {
		oLayer = $(oLayer);
		bModal = $(bModal) || false;
		if (!oLayer)
			return;
		if ($A(this.aOpenedLayers).has(oLayer))
			return;
		this.oApp.exec("POSITION_DIALOG_LAYER", [ oLayer ]);
		this.aOpenedLayers[this.aOpenedLayers.length] = oLayer;
		$A(this.aOpenedLayers).push(oLayer);
		if (!$A(this.aMadeDraggable).has(oLayer)) {
			new nhn.DraggableLayer(oLayer, {
				bModal : bModal,
				iMinY : 0
			});
			this.aMadeDraggable[this.aMadeDraggable.length] = oLayer;
		} else {
			oLayer.style.display = "block";
		}
	},
	$ON_HIDE_LAST_DIALOG_LAYER : function() {
		this.oApp.exec("HIDE_DIALOG_LAYER",
				[ this.aOpenedLayers[this.aOpenedLayers.length - 1] ]);
	},
	$ON_HIDE_ALL_DIALOG_LAYER : function() {
		for (var i = this.aOpenedLayers.length - 1; i >= 0; i--)
			this.oApp.exec("HIDE_DIALOG_LAYER", [ this.aOpenedLayers[i] ]);
	},
	$ON_HIDE_DIALOG_LAYER : function(oLayer) {
		oLayer = $(oLayer);
		if (oLayer)
			oLayer.style.display = "none";
		this.aOpenedLayers = $A(this.aOpenedLayers).refuse(oLayer);
	},
	$ON_SET_DIALOG_LAYER_POSITION : function(oLayer, iTop, iLeft) {
		oLayer.style.top = iTop;
		oLayer.style.left = iLeft;
	}
});
nhn.husky.ActiveLayerManager = $Class({
	name : "ActiveLayerManager",
	oCurrentLayer : null,
	$ON_TOGGLE_ACTIVE_LAYER : function(oLayer, sOnOpenCmd, aOnOpenParam,
			sOnCloseCmd, aOnCloseParam) {
		if (oLayer == this.oCurrentLayer) {
			this.oApp.exec("HIDE_ACTIVE_LAYER", []);
		} else {
			this.oApp.exec("SHOW_ACTIVE_LAYER", [ oLayer, sOnCloseCmd,
					aOnCloseParam ]);
			if (sOnOpenCmd)
				this.oApp.exec(sOnOpenCmd, aOnOpenParam);
		}
	},
	$ON_SHOW_ACTIVE_LAYER : function(oLayer, sOnCloseCmd, aOnCloseParam) {
		oLayer = $(oLayer);
		this.sOnCloseCmd = sOnCloseCmd;
		this.aOnCloseParam = aOnCloseParam;
		var oPrevLayer = this.oCurrentLayer;
		if (oLayer == oPrevLayer)
			return;
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
		oLayer.style.display = "block";
		this.oCurrentLayer = oLayer;
	},
	$ON_HIDE_ACTIVE_LAYER : function() {
		var oLayer = this.oCurrentLayer;
		if (!oLayer)
			return;
		oLayer.style.display = "none";
		this.oCurrentLayer = null;
		if (this.sOnCloseCmd)
			this.oApp.exec(this.sOnCloseCmd, this.aOnCloseParam);
	},
	$ON_HIDE_CURRENT_ACTIVE_LAYER : function() {
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	},
	$ON_EVENT_EDITING_AREA_KEYDOWN : function() {
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	},
	$ON_EVENT_EDITING_AREA_MOUSEDOWN : function() {
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	}
});
nhn.husky.StringConverterManager = $Class({
	name : "StringConverterManager",
	oConverters : null,
	$init : function() {
		this.oConverters = {};
	},
	$BEFORE_MSG_APP_READY : function() {
		this.oApp.exec("ADD_APP_PROPERTY", [ "applyConverter",
				$Fn(this.applyConverter, this).bind() ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "addConverter",
				$Fn(this.addConverter, this).bind() ]);
	},
	applyConverter : function(sRuleName, sContent) {
		var aConverters = this.oConverters[sRuleName];
		if (!aConverters)
			return sContent;
		for (var i = 0; i < aConverters.length; i++)
			sContent = aConverters[i](sContent);
		return sContent;
	},
	addConverter : function(sRuleName, funcConverter) {
		var aConverters = this.oConverters[sRuleName];
		if (!aConverters)
			this.oConverters[sRuleName] = [];
		this.oConverters[sRuleName][this.oConverters[sRuleName].length] = funcConverter;
	}
});
nhn.husky.MessageManager = $Class({
	name : "MessageManager",
	oMessageMap : null,
	$init : function(oMessageMap) {
		this.oMessageMap = oMessageMap;
	},
	$BEFORE_MSG_APP_READY : function() {
		this.oApp.exec("ADD_APP_PROPERTY", [ "$MSG",
				$Fn(this.getMessage, this).bind() ]);
	},
	getMessage : function(sMsg) {
		if (this.oMessageMap[sMsg])
			return unescape(this.oMessageMap[sMsg]);
		return sMsg;
	}
});
nhn.husky.SE_Toolbar = $Class({
	name : "SE_Toolbar",
	toolbarArea : null,
	toolbarButton : null,
	uiNameTag : "uiName",
	sUIClassPrefix : "husky_seditor_ui_",
	aUICmdMap : null,
	$init : function(oAppContainer) {
		this.htUIList = {};
		this.aUICmdMap = {};
		this._assignHTMLObjects(oAppContainer);
	},
	_assignHTMLObjects : function(oAppContainer) {
		oAppContainer = $(oAppContainer) || document;
		this.toolbarArea = cssquery.getSingle(".tool", oAppContainer);
		this.welToolbarArea = $Element(this.toolbarArea);
		this.aAllButtons = cssquery("BUTTON", this.toolbarArea);
		var aAllLi = this.toolbarArea.getElementsByTagName("LI");
		var nCount = aAllLi.length;
		var rxUI = new RegExp(this.sUIClassPrefix + "([^ ]+)");
		for (var i = 0; i < nCount; i++) {
			if (rxUI.test(aAllLi[i].className)) {
				var sUIName = RegExp.$1;
				if (this.htUIList[sUIName] != null)
					continue;
				this.htUIList[sUIName] = cssquery.getSingle(">*:first-child",
						aAllLi[i]);
			}
		}
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.registerBrowserEvent(this.toolbarArea, "mouseover",
				"EVENT_TOOLBAR_MOUSEOVER", []);
		this.oApp.registerBrowserEvent(this.toolbarArea, "mouseout",
				"EVENT_TOOLBAR_MOUSEOUT", []);
		this.oApp.exec("ADD_APP_PROPERTY", [ "getToolbarButtonByUIName",
				$Fn(this.getToolbarButtonByUIName, this).bind() ]);
	},
	$ON_EVENT_TOOLBAR_MOUSEOVER : function(weEvent) {
		if (weEvent.element.tagName == "BUTTON")
			$Element(weEvent.element).addClass("hover");
	},
	$ON_EVENT_TOOLBAR_MOUSEOUT : function(weEvent) {
		if (weEvent.element.tagName == "BUTTON")
			$Element(weEvent.element).removeClass("hover");
	},
	$ON_TOGGLE_TOOLBAR_ACTIVE_LAYER : function(oLayer, oBtn, sOpenCmd,
			aOpenArgs, sCloseCmd, aCloseArgs) {
		this.oApp.exec("TOGGLE_ACTIVE_LAYER", [ oLayer,
				"MSG_TOOLBAR_LAYER_SHOWN",
				[ oLayer, oBtn, sOpenCmd, aOpenArgs ], sCloseCmd, aCloseArgs ]);
	},
	$ON_MSG_TOOLBAR_LAYER_SHOWN : function(oLayer, oBtn, aOpenCmd, aOpenArgs) {
		this.oApp.exec("POSITION_TOOLBAR_LAYER", [ oLayer, oBtn ]);
		this.oApp.exec(aOpenCmd, aOpenArgs);
	},
	$ON_SHOW_TOOLBAR_ACTIVE_LAYER : function(oLayer, sCmd, aArgs, oBtn) {
		this.oApp.exec("SHOW_ACTIVE_LAYER", [ oLayer, sCmd, aArgs ]);
		this.oApp.exec("POSITION_TOOLBAR_LAYER", [ oLayer, oBtn ]);
	},
	$ON_ENABLE_UI : function(sUIName) {
		var elUI = this.htUIList[sUIName];
		if (!elUI)
			return;
		$Element(elUI).removeClass("off");
		elUI.disabled = false;
		var sCmd = "";
		if (this.aUICmdMap[sUIName]) {
			for (var i = 0; i < this.aUICmdMap[sUIName].length; i++) {
				sCmd = this.aUICmdMap[sUIName][i];
				this.oApp.exec("ENABLE_COMMAND", [ sCmd ]);
			}
		}
	},
	$ON_DISABLE_UI : function(sUIName) {
		var elUI = this.htUIList[sUIName];
		if (!elUI)
			return;
		$Element(elUI).addClass("off");
		$Element(elUI).removeClass("hover");
		elUI.disabled = true;
		var sCmd = "";
		if (this.aUICmdMap[sUIName]) {
			for (var i = 0; i < this.aUICmdMap[sUIName].length; i++) {
				sCmd = this.aUICmdMap[sUIName][i];
				this.oApp.exec("DISABLE_COMMAND", [ sCmd ]);
			}
		}
	},
	$ON_SELECT_UI : function(sUIName) {
		var elUI = this.htUIList[sUIName];
		if (!elUI)
			return;
		$Element(elUI).addClass("active");
	},
	$ON_DESELECT_UI : function(sUIName) {
		var elUI = this.htUIList[sUIName];
		if (!elUI)
			return;
		$Element(elUI).removeClass("active");
	},
	$ON_ENABLE_ALL_UI : function() {
		var sUIName, className;
		for ( var sUIName in this.htUIList) {
			if (sUIName)
				this.oApp.exec("ENABLE_UI", [ sUIName ]);
		}
		$Element(this.toolbarArea).removeClass("off");
	},
	$ON_DISABLE_ALL_UI : function() {
		var sUIName;
		for ( var sUIName in this.htUIList) {
			if (sUIName)
				this.oApp.exec("DISABLE_UI", [ sUIName ]);
		}
		$Element(this.toolbarArea).addClass("off");
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	},
	$ON_MSG_STYLE_CHANGED : function(sAttributeName, attributeValue) {
		if (attributeValue == 1)
			this.oApp.exec("SELECT_UI", [ sAttributeName ]);
		else
			this.oApp.exec("DESELECT_UI", [ sAttributeName ]);
	},
	$ON_REGISTER_UI_EVENT : function(sUIName, sEvent, sCmd, aParams) {
		if (!this.aUICmdMap[sUIName]) {
			this.aUICmdMap[sUIName] = [];
		}
		this.aUICmdMap[sUIName][this.aUICmdMap[sUIName].length] = sCmd;
		var elUI = this.htUIList[sUIName];
		if (!elUI)
			return;
		this.oApp.registerBrowserEvent(elUI, sEvent, sCmd, aParams);
	},
	$ON_POSITION_TOOLBAR_LAYER : function(oLayer, oBtn) {
		oLayer = $(oLayer);
		oBtn = $(oBtn);
		if (!oLayer)
			return;
		if (oBtn && oBtn.tagName && oBtn.tagName == "BUTTON")
			oBtn.parentNode.appendChild(oLayer);
		oLayer.style.left = "0";
		var welLayer = $Element(oLayer);
		var nLayerLeft = welLayer.offset().left;
		nLayerLeft += oLayer.offsetWidth;
		var nToolbarLeft = this.welToolbarArea.offset().left;
		nToolbarLeft += this.toolbarArea.offsetWidth;
		if (nLayerLeft > nToolbarLeft)
			oLayer.style.left = (nToolbarLeft - nLayerLeft - 5) + "px";
	},
	getToolbarButtonByUIName : function(sUIName) {
		return this.htUIList[sUIName];
	}
});
nhn.husky.SE_EditingAreaManager = $Class({
	name : "SE_EditingAreaManager",
	oActivePlugin : null,
	oIRField : null,
	bIsDirty : false,
	$init : function(sInitialMode, oIRField, oDimension, fOnBeforeUnload,
			oAppContainer) {
		this.sInitialMode = sInitialMode;
		this.oIRField = $(oIRField);
		this._assignHTMLObjects(oAppContainer);
		this.fOnBeforeUnload = fOnBeforeUnload;
		var welEditingAreaContiner = $Element(this.elEditingAreaContainer);
		this.elEditingAreaContainer.style.height = parseInt(oDimension.nHeight
				|| this.elEditingAreaContainer.offsetHeight)
				+ "px";
		this.nMinHeight = oDimension.nMinHeight || 10;
		this.niMinWidth = oDimension.nMinWidth || 10;
	},
	_assignHTMLObjects : function(oAppContainer) {
		oAppContainer = $(oAppContainer) || document;
		this.elEditingAreaContainer = cssquery.getSingle(
				"DIV.husky_seditor_editing_area_container", oAppContainer);
	},
	$BEFORE_MSG_APP_READY : function(msg) {
		this.oApp.exec("ADD_APP_PROPERTY", [ "elEditingAreaContainer",
				this.elEditingAreaContainer ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "getIR", this.getIR ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "setIR", this.setIR ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "getEditingMode",
				$Fn(this.getEditingMode, this).bind() ]);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("CHANGE_EDITING_MODE", [ this.sInitialMode, true ]);
		this.oApp.exec("LOAD_IR_FIELD", [ false ]);
		if (this.fOnBeforeUnload) {
			$Fn(this.fOnBeforeUnload, this).attach(window, "beforeunload");
		} else {
			$Fn(function() {
				if (this.getIR() != this.oIRField.value || this.bIsDirty)
					return this.oApp.$MSG("SE_EditingAreaManager.onExit");
			}, this).attach(window, "beforeunload");
		}
	},
	$AFTER_MSG_APP_READY : function() {
		this.oApp.exec("UPDATE_IR_FIELD", []);
	},
	$ON_LOAD_IR_FIELD : function(bDontAddUndo) {
		this.oApp.setIR(this.oIRField.value, bDontAddUndo);
	},
	$ON_UPDATE_IR_FIELD : function() {
		this.oIRField.value = this.oApp.getIR();
	},
	$BEFORE_CHANGE_EDITING_MODE : function(sMode) {
		this._oPrevActivePlugin = this.oActivePlugin;
		this.oActivePlugin = this.oApp.plugins["SE_EditingArea_" + sMode];
	},
	$AFTER_CHANGE_EDITING_MODE : function() {
		if (this._oPrevActivePlugin) {
			var sIR = this._oPrevActivePlugin.getIR();
			this.oApp.exec("SET_IR", [ sIR ]);
			this.oApp.exec("ENABLE_UI", [ this._oPrevActivePlugin.sMode ]);
			this._setEditingAreaDimension();
		}
		this.oApp.exec("DISABLE_UI", [ this.oActivePlugin.sMode ]);
	},
	$ON_SET_IS_DIRTY : function(bIsDirty) {
		this.bIsDirty = bIsDirty;
	},
	$ON_FOCUS : function() {
		if (!this.oActivePlugin
				|| typeof this.oActivePlugin.setIR != "function")
			return

		this.oActivePlugin.focus();
	},
	$BEFORE_SET_IR : function(sIR, bDontAddUndoHistory) {
		bDontAddUndoHistory = bDontAddUndoHistory || false;
		if (!bDontAddUndoHistory)
			this.oApp.exec("RECORD_UNDO_ACTION", [ "SET CONTENTS" ]);
	},
	$ON_SET_IR : function(sIR) {
		if (!this.oActivePlugin
				|| typeof this.oActivePlugin.setIR != "function")
			return

		this.oActivePlugin.setIR(sIR);
	},
	$AFTER_SET_IR : function(sIR, bDontAddUndoHistory) {
		bDontAddUndoHistory = bDontAddUndoHistory || false;
		if (!bDontAddUndoHistory)
			this.oApp.exec("RECORD_UNDO_ACTION", [ "SET CONTENTS" ]);
	},
	$ON_REGISTER_EDITING_AREA : function(oEditingArea) {
		this.attachDocumentEvents(oEditingArea);
	},
	$ON_MSG_EDITING_AREA_RESIZE_STARTED : function() {
		this.oActivePlugin.elEditingArea.style.display = "none";
		this.iStartingHeight = parseInt(this.elEditingAreaContainer.style.height);
	},
	$ON_RESIZE_EDITING_AREA : function(ipNewWidth, ipNewHeight) {
		var iNewWidth = parseInt(ipNewWidth);
		var iNewHeight = parseInt(ipNewHeight);
		if (iNewWidth < this.niMinWidth)
			iNewWidth = this.niMinWidth;
		if (iNewHeight < this.nMinHeight)
			iNewHeight = this.nMinHeight;
		if (ipNewWidth)
			this.elEditingAreaContainer.style.width = iNewWidth + "px";
		if (ipNewHeight)
			this.elEditingAreaContainer.style.height = iNewHeight + "px";
	},
	$ON_RESIZE_EDITING_AREA_BY : function(ipWidthChange, ipHeightChange) {
		var iWidthChange = parseInt(ipWidthChange);
		var iHeightChange = parseInt(ipHeightChange);
		var iWidth = this.elEditingAreaContainer.style.width ? parseInt(this.elEditingAreaContainer.style.width)
				+ iWidthChange
				: null;
		var iHeight = this.elEditingAreaContainer.style.height ? this.iStartingHeight
				+ iHeightChange
				: null;
		this.oApp.exec("RESIZE_EDITING_AREA", [ iWidth, iHeight ]);
	},
	$ON_MSG_EDITING_AREA_RESIZE_ENDED : function(FnMouseDown, FnMouseMove,
			FnMouseUp) {
		this.oActivePlugin.elEditingArea.style.display = "block";
		this._setEditingAreaDimension();
	},
	_setEditingAreaDimension : function() {
		this.oActivePlugin.elEditingArea.style.height = this.elEditingAreaContainer.style.height;
		this.oActivePlugin.elEditingArea.style.width = this.elEditingAreaContainer.style.width;
	},
	attachDocumentEvents : function(doc) {
		this.oApp
				.registerBrowserEvent(doc, "click", "EVENT_EDITING_AREA_CLICK");
		this.oApp.registerBrowserEvent(doc, "mousedown",
				"EVENT_EDITING_AREA_MOUSEDOWN");
		this.oApp.registerBrowserEvent(doc, "mousemove",
				"EVENT_EDITING_AREA_MOUSEMOVE");
		this.oApp.registerBrowserEvent(doc, "mouseup",
				"EVENT_EDITING_AREA_MOUSEUP");
	},
	getIR : function() {
		return this.oApp.plugins["SE_EditingAreaManager"].oActivePlugin.getIR();
	},
	setIR : function(sIR, bDontAddUndo) {
		this.oApp.exec("SET_IR", [ sIR, bDontAddUndo ]);
	},
	getEditingMode : function() {
		return this.oActivePlugin.sMode;
	}
});
nhn.husky.SE_EditingArea_HTMLSrc = $Class({
	name : "SE_EditingArea_HTMLSrc",
	requiredPlugin : [ "SE_EditingAreaManager" ],
	sMode : "HTMLSrc",
	textarea : null,
	$init : function(textarea) {
		this.textarea = $(textarea);
		this.elEditingArea = this.textarea;
	},
	$BEFORE_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_EDITING_AREA", [ this.textarea ]);
	},
	$ON_CHANGE_EDITING_MODE : function(sMode, bNoFocus) {
		if (sMode == this.sMode) {
			this.textarea.style.display = "block";
		} else {
			this.textarea.style.display = "none";
		}
	},
	$AFTER_CHANGE_EDITING_MODE : function(sMode, bNoFocus) {
		if (!bNoFocus && sMode == this.sMode) {
			this.focus();
		}
	},
	getIR : function() {
		var sIR;
		var sContent = this.textarea.value;
		if (this.oApp.applyConverter)
			sIR = this.oApp.applyConverter(this.sMode + "_TO_IR", sContent);
		else
			sIR = sContent;
		return sIR;
	},
	setIR : function(sIR) {
		var sContent;
		if (this.oApp.applyConverter)
			sContent = this.oApp.applyConverter("IR_TO_" + this.sMode, sIR);
		else
			sContent = sIR;
		this.textarea.value = sContent;
	},
	focus : function() {
		this.textarea.focus();
	}
});
nhn.husky.SE_EditingArea_WYSIWYG = $Class({
	name : "SE_EditingArea_WYSIWYG",
	status : nhn.husky.PLUGIN_STATUS["NOT_READY"],
	sMode : "WYSIWYG",
	iframe : null,
	doc : null,
	iLastUndoRecorded : 0,
	iMinUndoInterval : 3000,
	_nIFrameReadyCount : 50,
	$init : function(iframe) {
		this.iframe = $(iframe);
		this.initIframe();
		this.elEditingArea = iframe;
	},
	$BEFORE_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_EDITING_AREA", [ this.doc ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "getWYSIWYGWindow",
				$Fn(this.getWindow, this).bind() ]);
		this.oApp.exec("ADD_APP_PROPERTY", [ "getWYSIWYGDocument",
				$Fn(this.getDocument, this).bind() ]);
	},
	$ON_MSG_APP_READY : function() {
		if ($Agent().navigator().ie) {
			$Fn(
					function(weEvent) {
						if (this.doc.selection.type.toLowerCase() == 'control'
								&& weEvent.key().keyCode == 8) {
							this.oApp.exec("EXECCOMMAND", [ 'delete', false,
									false ]);
							weEvent.stop();
						}
					}, this).attach(this.doc, "keydown");
		}
	},
	$ON_CHANGE_EDITING_MODE : function(sMode, bNoFocus) {
		if (sMode == this.sMode) {
			this.iframe.style.display = "block";
			this.oApp.exec("REFRESH_WYSIWYG", []);
			this.oApp.exec("SET_EDITING_WINDOW", [ this.getWindow() ]);
		} else {
			this.iframe.style.display = "none";
		}
	},
	$AFTER_CHANGE_EDITING_MODE : function(sMode, bNoFocus) {
		if (!bNoFocus && sMode == this.sMode) {
			this.focus();
		}
	},
	$ON_REFRESH_WYSIWYG : function() {
		if (this.doc.body.contentEditable) {
			this.doc.body.contentEditable = false;
			this.doc.body.contentEditable = true;
		}
	},
	$ON_ENABLE_WYSIWYG : function() {
		this._enableWYSIWYG();
	},
	$ON_DISABLE_WYSIWYG : function() {
		if (this.doc.body.contentEditable) {
			this.doc.body.contentEditable = false;
		} else {
			this.doc.designMode = "off";
		}
	},
	$ON_EVENT_EDITING_AREA_KEYUP : function(oEvent) {
		var oKeyInfo = oEvent.key();
		if (oKeyInfo.keyCode == 229 || oKeyInfo.enter || oKeyInfo.alt
				|| oKeyInfo.ctrl
				|| (oKeyInfo.keyCode >= 33 && oKeyInfo.keyCode <= 40)
				|| oKeyInfo.keyCode == 16)
			return;
		this._recordUndo(oKeyInfo)
	},
	$ON_PASTE_HTML : function(sHTML, oPSelection) {
		var oSelection = oPSelection || this.oApp.getSelection();
		oSelection.pasteHTML(sHTML);
		if (!$Agent().navigator().ie) {
			var sTmpBookmark = oSelection.placeStringBookmark();
			this.oApp.getWYSIWYGDocument().body.innerHTML = this.oApp
					.getWYSIWYGDocument().body.innerHTML;
			oSelection.moveToBookmark(sTmpBookmark);
			oSelection.collapseToEnd();
			oSelection.select();
			oSelection.removeStringBookmark(sTmpBookmark);
		}
		this.oApp.exec("RECORD_UNDO_ACTION", [ "INSERT HTML" ]);
	},
	initIframe : function() {
		try {
			this.doc = this.iframe.contentWindow.document;
			if (this.doc == null || this.doc.location.href == 'about:blank') {
				throw new Error('Access denied');
			}
			this._enableWYSIWYG();
			this.status = nhn.husky.PLUGIN_STATUS["READY"];
		} catch (e) {
			if (this._nIFrameReadyCount-- > 0) {
				setTimeout($Fn(this.initIframe, this).bind(), 100);
			} else {
				throw ("iframe for WYSIWYG editing mode can't be initialized. Please check if the iframe document exists and is also accessable(cross-domain issues). ");
			}
		}
	},
	getIR : function() {
		var sContent = this.doc.body.innerHTML;
		var sIR;
		if (this.oApp.applyConverter)
			sIR = this.oApp.applyConverter(this.sMode + "_TO_IR", sContent);
		else
			sIR = sContent;
		return sIR;
	},
	setIR : function(sIR) {
		var sContent;
		if (this.oApp.applyConverter)
			sContent = this.oApp.applyConverter("IR_TO_" + this.sMode, sIR);
		else
			sContent = sIR;
		this.doc.body.innerHTML = sContent;
		if (this.oApp.oNavigatorInfo.firefox) {
			if (this.doc.body.innerHTML == "")
				this.doc.body.innerHTML = "<br>";
		}
	},
	getWindow : function() {
		return this.iframe.contentWindow;
	},
	getDocument : function() {
		return this.iframe.contentWindow.document;
	},
	focus : function() {
		this.getWindow().focus();
	},
	_recordUndo : function(oKeyInfo) {
		var curTime = new Date();
		if (curTime - this.iLastUndoRecorded < this.iMinUndoInterval)
			return;
		this.oApp.exec("RECORD_UNDO_ACTION", [ "KEYPRESS" ]);
		this.iLastUndoRecorded = new Date();
		this.prevKeyCode = oKeyInfo.keyCode;
	},
	_enableWYSIWYG : function() {
		if (this.doc.body.contentEditable) {
			this.doc.body.contentEditable = true;
		} else {
			this.doc.designMode = "on";
		}
	}
});
nhn.husky.SE_OuterIFrameControl = $Class({
	name : "SE_OuterIFrameControl",
	oResizeGrip : null,
	$init : function(oAppContainer) {
		this._assignHTMLObjects(oAppContainer);
		this.$FnMouseDown = $Fn(this._mousedown, this);
		this.$FnMouseMove = $Fn(this._mousemove, this);
		this.$FnMouseMove_Parent = $Fn(this._mousemove_parent, this);
		this.$FnMouseUp = $Fn(this._mouseup, this);
		this.$FnMouseDown.attach(this.oResizeGrip, "mousedown");
	},
	_assignHTMLObjects : function(oAppContainer) {
		oAppContainer = $(oAppContainer) || document;
		this.oResizeGrip = cssquery.getSingle(
				".husky_seditor_editingArea_verticalResizer", oAppContainer);
		this.elIFrame = window.frameElement;
		this.welIFrame = $Element(this.elIFrame);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("SE_FIT_IFRAME", []);
	},
	$ON_SE_FIT_IFRAME : function() {
		this.elIFrame.style.height = document.body.offsetHeight + "px";
	},
	$AFTER_RESIZE_EDITING_AREA_BY : function(ipWidthChange, ipHeightChange) {
		this.oApp.exec("SE_FIT_IFRAME", []);
	},
	_mousedown : function(oEvent) {
		this.iStartHeight = oEvent.pos().clientY;
		this.iStartHeightOffset = oEvent.pos().layerY;
		this.$FnMouseMove.attach(document, "mousemove");
		this.$FnMouseMove_Parent.attach(parent.document, "mousemove");
		this.$FnMouseUp.attach(document, "mouseup");
		this.$FnMouseUp.attach(parent.document, "mouseup");
		this.iStartHeight = oEvent.pos().clientY;
		this.oApp.exec("MSG_EDITING_AREA_RESIZE_STARTED", [ this.$FnMouseDown,
				this.$FnMouseMove, this.$FnMouseUp ]);
	},
	_mousemove : function(oEvent) {
		var iHeightChange = oEvent.pos().clientY - this.iStartHeight;
		this.oApp.exec("RESIZE_EDITING_AREA_BY", [ 0, iHeightChange ]);
	},
	_mousemove_parent : function(oEvent) {
		var iHeightChange = oEvent.pos().clientY
				- (this.welIFrame.offset().top + this.iStartHeight);
		this.oApp.exec("RESIZE_EDITING_AREA_BY", [ 0, iHeightChange ]);
	},
	_mouseup : function(oEvent) {
		this.$FnMouseMove.detach(document, "mousemove");
		this.$FnMouseMove_Parent.detach(parent.document, "mousemove");
		this.$FnMouseUp.detach(document, "mouseup");
		this.$FnMouseUp.detach(parent.document, "mouseup");
		this.oApp.exec("MSG_EDITING_AREA_RESIZE_ENDED", [ this.$FnMouseDown,
				this.$FnMouseMove, this.$FnMouseUp ]);
	}
});
nhn.husky.SE_ExecCommand = $Class({
	name : "SE_ExecCommand",
	oEditingArea : null,
	$init : function(oEditingArea) {
		this.oEditingArea = oEditingArea;
	},
	$BEFORE_MSG_APP_READY : function() {
		if (this.oEditingArea && this.oEditingArea.tagName == "IFRAME")
			this.oEditingArea = this.oEditingArea.contentWindow.document;
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+b", "EXECCOMMAND",
				[ "bold", false, false ] ]);
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+u", "EXECCOMMAND",
				[ "underline", false, false ] ]);
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+i", "EXECCOMMAND",
				[ "italic", false, false ] ]);
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+d", "EXECCOMMAND",
				[ "strikethrough", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "bold", "click", "EXECCOMMAND",
				[ "bold", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "underline", "click",
				"EXECCOMMAND", [ "underline", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "italic", "click", "EXECCOMMAND",
				[ "italic", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "lineThrough", "click",
				"EXECCOMMAND", [ "strikethrough", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "superscript", "click",
				"EXECCOMMAND", [ "superscript", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "subscript", "click",
				"EXECCOMMAND", [ "subscript", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "justifyleft", "click",
				"EXECCOMMAND", [ "justifyleft", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "justifycenter", "click",
				"EXECCOMMAND", [ "justifycenter", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "justifyright", "click",
				"EXECCOMMAND", [ "justifyright", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "justifyfull", "click",
				"EXECCOMMAND", [ "justifyfull", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "orderedlist", "click",
				"EXECCOMMAND", [ "insertorderedlist", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "unorderedlist", "click",
				"EXECCOMMAND", [ "insertunorderedlist", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "outdent", "click",
				"EXECCOMMAND", [ "outdent", false, false ] ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "indent", "click", "EXECCOMMAND",
				[ "indent", false, false ] ]);
	},
	$BEFORE_EXECCOMMAND : function(sCommand, bUserInterface, vValue) {
		this._bOnlyCursorChanged = false;
		if (sCommand
				.match(/^bold|underline|italic|strikethrough|superscript|subscript$/i)) {
			var oSelection = this.oApp.getSelection();
			if (oSelection.collapsed)
				this._bOnlyCursorChanged = true;
		}
		if (!this._bOnlyCursorChanged) {
			this.oApp.exec("RECORD_UNDO_BEFORE_ACTION", [ sCommand ]);
		}
	},
	$ON_EXECCOMMAND : function(sCommand, bUserInterface, vValue) {
		bUserInterface = (bUserInterface == "" || bUserInterface) ? bUserInterface
				: false;
		vValue = (vValue == "" || vValue) ? vValue : false;
		this.oEditingArea.execCommand(sCommand, bUserInterface, vValue);
	},
	$AFTER_EXECCOMMAND : function(sCommand, bUserInterface, vValue) {
		if (!this._bOnlyCursorChanged) {
			this.oApp.exec("RECORD_UNDO_AFTER_ACTION", [ sCommand ]);
		}
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	}
});
nhn.husky.SE_WYSIWYGEnterKey = $Class({
	name : "SE_WYSIWYGEnterKey",
	unsupportedBrowser : [ 'ie', 'opera' ],
	oEditingArea : null,
	$init : function(oEditingArea) {
		this.oEditingArea = oEditingArea;
	},
	$BEFORE_MSG_APP_READY : function() {
		if (this.oEditingArea && this.oEditingArea.tagName == "IFRAME")
			this.oEditingArea = this.oEditingArea.contentWindow.document;
	},
	$ON_EVENT_EDITING_AREA_KEYDOWN : function(oEvent) {
		if (this.oApp.getEditingMode() != "WYSIWYG")
			return;
		var oKeyInfo = oEvent.key();
		if (oKeyInfo.shift)
			return;
		if (oKeyInfo.enter) {
			var oSelection = this.oApp.getSelection();
			var sBM = oSelection.placeStringBookmark();
			var oLineInfo = oSelection.getLineInfo();
			var oStart = oLineInfo.oStart;
			var oEnd = oLineInfo.oEnd;
			if (!oStart.bParentBreak
					|| oSelection.rxBlockContainer
							.test(oStart.oLineBreaker.tagName)) {
				oEvent.stop();
				var oSWrapper = this.oEditingArea.createElement("P");
				oSelection.moveToBookmark(sBM);
				oSelection.setStartBefore(oStart.oNode);
				oSelection.surroundContents(oSWrapper);
				oSelection.collapseToEnd();
				var oEWrapper = this.oEditingArea.createElement("P");
				oSelection.setEndAfter(oEnd.oNode);
				oSelection.surroundContents(oEWrapper);
				oSelection.removeStringBookmark(sBM);
				if (oSWrapper.innerHTML == "")
					oSWrapper.innerHTML = "<br>";
				if (oEWrapper.innerHTML == "")
					oEWrapper.innerHTML = "<br>";
				if (oEWrapper.nextSibling
						&& oEWrapper.nextSibling.tagName == "BR")
					oEWrapper.parentNode.removeChild(oEWrapper.nextSibling);
				oSelection.selectNodeContents(oEWrapper);
				oSelection.collapseToStart();
				oSelection.select();
				this.oApp.exec("CHECK_STYLE_CHANGE", []);
			} else {
				oSelection.removeStringBookmark(sBM);
			}
		}
	}
});
nhn.husky.SE_WYSIWYGStyler = $Class({
	name : "SE_WYSIWYGStyler",
	requiredPlugin : [ "SE_EditingArea_WYSIWYG", "HuskyRangeManager" ],
	$PRECONDITION : function(sFullCommand, aArgs) {
		return (this.oApp.getEditingMode() == "WYSIWYG");
	},
	$ON_SET_WYSIWYG_STYLE : function(oStyles) {
		var oSelection = this.oApp.getSelection();
		if (oSelection.collapsed) {
			var oSpan = this.oApp.getWYSIWYGDocument().createElement("SPAN");
			oSelection.insertNode(oSpan);
			oSpan.innerHTML = unescape("%uFEFF");
			var sValue;
			for ( var sName in oStyles) {
				sValue = oStyles[sName];
				if (typeof sValue != "string")
					continue;
				oSpan.style[sName] = sValue;
			}
			oSelection.selectNodeContents(oSpan);
			oSelection.collapseToEnd();
			oSelection._window.focus();
			oSelection._window.document.body.focus();
			oSelection.select();
			if (this.oApp.oNavigatorInfo.firefox
					&& this.oApp.oNavigatorInfo.version == 3)
				oSpan.innerHTML = "";
			return;
		}
		this.oApp.exec("RECORD_UNDO_BEFORE_ACTION", [ "FONT STYLE" ]);
		oSelection.styleRange(oStyles);
		oSelection._window.focus();
		oSelection.select();
		this.oApp.exec("RECORD_UNDO_AFTER_ACTION", [ "FONT STYLE" ]);
	}
});
nhn.husky.SE_WYSIWYGStyleGetter = $Class({
	name : "SE_WYSIWYGStyleGetter",
	hKeyUp : null,
	getStyleInterval : 200,
	oStyleMap : {
		fontFamily : {
			type : "Value",
			css : "fontFamily"
		},
		fontSize : {
			type : "Value",
			css : "fontSize"
		},
		lineHeight : {
			type : "Value",
			css : "lineHeight",
			converter : function(sValue, oStyle) {
				if (!sValue.match(/px$/))
					return sValue;
				return Math
						.ceil((parseInt(sValue) / parseInt(oStyle.fontSize)) * 10) / 10;
			}
		},
		bold : {
			command : "bold"
		},
		underline : {
			command : "underline"
		},
		italic : {
			command : "italic"
		},
		lineThrough : {
			command : "strikethrough"
		},
		superscript : {
			command : "superscript"
		},
		subscript : {
			command : "subscript"
		},
		justifyleft : {
			command : "justifyleft"
		},
		justifycenter : {
			command : "justifycenter"
		},
		justifyright : {
			command : "justifyright"
		},
		justifyfull : {
			command : "justifyfull"
		},
		orderedlist : {
			command : "insertunorderedlist"
		},
		unorderedlist : {
			command : "insertunorderedlist"
		}
	},
	$init : function() {
		this.oStyle = this._getBlankStyle();
	},
	$PRECONDITION : function() {
		if (this.oApp.getEditingMode() != "WYSIWYG")
			return false;
		return true;
	},
	$ON_MSG_APP_READY : function() {
		this.oDocument = this.oApp.getWYSIWYGDocument();
		this.oApp.exec("ADD_APP_PROPERTY", [ "getCurrentStyle",
				$Fn(this.getCurrentStyle, this).bind() ]);
	},
	$ON_EVENT_EDITING_AREA_MOUSEUP : function(oEvnet) {
		if (this.hKeyUp)
			clearTimeout(this.hKeyUp);
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	},
	$ON_EVENT_EDITING_AREA_KEYUP : function(oEvent) {
		var oKeyInfo = oEvent.key();
		if (!(oKeyInfo.keyCode == 8
				|| (oKeyInfo.keyCode >= 33 && oKeyInfo.keyCode <= 40)
				|| oKeyInfo.keyCode == 45 || oKeyInfo.keyCode == 46))
			return;
		if (this.hKeyUp)
			clearTimeout(this.hKeyUp);
		this.hKeyUp = setTimeout($Fn(this.oApp.exec, this.oApp).bind(
				"CHECK_STYLE_CHANGE", []), this.getStyleInterval);
	},
	$ON_CHECK_STYLE_CHANGE : function() {
		this._getStyle();
	},
	$ON_RESET_STYLE_STATUS : function() {
		var oBlankStyle = this._getBlankStyle();
		for ( var sAttributeName in oBlankStyle)
			this.oApp.exec("SET_STYLE_STATUS", [ sAttributeName,
					oBlankStyle[sAttributeName] ]);
	},
	getCurrentStyle : function() {
		return this.oStyle;
	},
	_check_style_change : function() {
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	},
	_getBlankStyle : function() {
		var oBlankStyle = {};
		for ( var attributeName in this.oStyleMap) {
			if (this.oStyleMap[attributeName].type == "Value")
				oBlankStyle[attributeName] = "";
			else
				oBlankStyle[attributeName] = 0;
		}
		return oBlankStyle;
	},
	_getStyle : function() {
		var oSelection = this.oApp.getSelection();
		var funcFilter = function(oNode) {
			if (!oNode.childNodes || oNode.childNodes.length == 0)
				return true;
			else
				return false;
		}
		var aBottomNodes = oSelection.getNodes(false, funcFilter);
		var oStyle, oBaseStyle, oTmpStyle, attributeName;
		if (aBottomNodes.length == 0) {
			oStyle = this._getStyleOf(oSelection.commonAncestorContainer);
		} else {
			oStyle = this._getStyleOf(aBottomNodes[0]);
		}
		for (attributeName in oStyle) {
			if (this.oStyleMap[attributeName].converter) {
				oStyle[attributeName] = this.oStyleMap[attributeName]
						.converter(oStyle[attributeName], oStyle);
			}
			if (this.oStyle[attributeName] != oStyle[attributeName])
				this.oApp.exec("MSG_STYLE_CHANGED", [ attributeName,
						oStyle[attributeName] ]);
		}
		this.oStyle = oStyle;
	},
	_getStyleOf : function(oNode) {
		var oStyle = this._getBlankStyle();
		if (!oNode)
			return oStyle;
		if (oNode.nodeType == 3)
			oNode = oNode.parentNode;
		var welNode = $Element(oNode);
		var attribute, cssName;
		for ( var styleName in this.oStyle) {
			attribute = this.oStyleMap[styleName];
			if (attribute.type && attribute.type == "Value") {
				if (attribute.css) {
					var sValue = welNode.css(attribute.css);
					if (styleName == "fontFamily") {
						sValue = sValue.split(/,/)[0];
					}
					oStyle[styleName] = sValue;
				} else {
					if (attribute.command) {
						try {
							oStyle[styleName] = this.oDocument
									.queryCommandState(attribute.command);
						} catch (e) {
						}
					} else {
					}
				}
			} else {
				if (attribute.command) {
					try {
						if (this.oDocument.queryCommandState(attribute.command)) {
							oStyle[styleName] = 1;
						} else {
							oStyle[styleName] = 0;
						}
					} catch (e) {
					}
				} else {
				}
			}
		}
		return oStyle;
	}
});
nhn.husky.SE_FontSizeWithSelectUI = $Class({
	name : "SE_FontSizeWithSelectUI",
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.elFontSizeSelect = cssquery.getSingle(
				"SELECT.husky_seditor_ui_fontSize_select", elAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.registerBrowserEvent(this.elFontSizeSelect, "change",
				"SET_FONTSIZE_FROM_SELECT_UI");
		this.elFontSizeSelect.selectedIndex = 0;
	},
	$ON_MSG_STYLE_CHANGED : function(sAttributeName, sAttributeValue) {
		if (sAttributeName == "fontSize") {
			this.elFontSizeSelect.value = sAttributeValue;
			if (this.elFontSizeSelect.selectedIndex < 0)
				this.elFontSizeSelect.selectedIndex = 0;
		}
	},
	$ON_SET_FONTSIZE_FROM_SELECT_UI : function() {
		var sFontSize = this.elFontSizeSelect.value;
		if (!sFontSize)
			return;
		this.oApp.exec("SET_WYSIWYG_STYLE", [ {
			"fontSize" : sFontSize
		} ]);
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	}
});
nhn.husky.SE_FontNameWithSelectUI = $Class({
	name : "SE_FontNameWithSelectUI",
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.elFontNameSelect = cssquery.getSingle(
				"SELECT.husky_seditor_ui_fontName_select", elAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.registerBrowserEvent(this.elFontNameSelect, "change",
				"SET_FONTNAME_FROM_SELECT_UI");
		this.elFontNameSelect.selectedIndex = 0;
	},
	$ON_MSG_STYLE_CHANGED : function(sAttributeName, sAttributeValue) {
		if (sAttributeName == "fontFamily") {
			this.elFontNameSelect.value = sAttributeValue.toLowerCase();
			if (this.elFontNameSelect.selectedIndex < 0)
				this.elFontNameSelect.selectedIndex = 0;
		}
	},
	$ON_SET_FONTNAME_FROM_SELECT_UI : function() {
		var sFontName = this.elFontNameSelect.value;
		if (!sFontName)
			return;
		this.oApp.exec("SET_WYSIWYG_STYLE", [ {
			"fontFamily" : sFontName
		} ]);
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	}
});
nhn.husky.SE_LineHeight = $Class({
	name : "SE_LineHeight",
	$init : function(oAppContainer) {
		this._assignHTMLObjects(oAppContainer);
	},
	_assignHTMLObjects : function(oAppContainer) {
	},
	$ON_SET_LINEHEIGHT : function(nLineHeight) {
		this.setLineHeight(nLineHeight);
	},
	getLineHeight : function() {
		var nodes = this._getSelectedNodes(false);
		var curWrapper, prevWrapper;
		var iCurHeight, iHeight;
		if (nodes.length == 0)
			return -1;
		var iLength = nodes.length;
		if (iLength == 0) {
			iHeight = -1;
		} else {
			prevWrapper = this._getLineWrapper(nodes[0]);
			iHeight = this._getWrapperLineheight(prevWrapper);
		}
		var firstNode = this.oSelection.getStartNode();
		if (iHeight > 0) {
			for (var i = 1; i < iLength; i++) {
				if (this._isChildOf(nodes[i], curWrapper))
					continue;
				if (!nodes[i])
					continue;
				curWrapper = this._getLineWrapper(nodes[i]);
				if (curWrapper == prevWrapper)
					continue;
				curHeight = this._getWrapperLineheight(curWrapper);
				if (curHeight != iHeight) {
					iHeight = -1;
					break;
				}
				prevWrapper = curWrapper;
			}
		}
		curWrapper = this._getLineWrapper(nodes[iLength - 1]);
		var lastNode = this.oSelection.getEndNode();
		selectText = $Fn(function(firstNode, lastNode) {
			this.oSelection.setEndNodes(firstNode, lastNode);
			this.oSelection.select();
		}, this).bind(firstNode, lastNode);
		setTimeout(selectText, 100);
		return iHeight;
	},
	setLineHeight : function(height) {
		thisRef = this;
		function _setLineheight(div, height) {
			if (!div) {
				try {
					div = thisRef.oSelection.surroundContentsWithNewNode("P");
				} catch (e) {
					div = thisRef.oSelection.surroundContentsWithNewNode("DIV");
				}
			}
			div.style.lineHeight = height;
			return div;
		}
		function isInBody(node) {
			while (node && node.tagName != "BODY") {
				node = nhn.DOMFix.parentNode(node);
			}
			if (!node)
				return false;
			return true;
		}
		var nodes = this._getSelectedNodes(false);
		if (nodes.length == 0) {
			return;
		}
		var curWrapper, prevWrapper;
		var iLength = nodes.length;
		this.oApp.exec("RECORD_UNDO_BEFORE_ACTION", [ "LINEHEIGHT" ]);
		prevWrapper = this._getLineWrapper(nodes[0]);
		prevWrapper = _setLineheight(prevWrapper, height);
		var startNode = prevWrapper;
		var endNode = prevWrapper;
		for (var i = 1; i < iLength; i++) {
			try {
				if (!isInBody(nhn.DOMFix.parentNode(nodes[i])))
					continue;
			} catch (e) {
				continue;
			}
			if (this._isChildOf(nodes[i], curWrapper))
				continue;
			curWrapper = this._getLineWrapper(nodes[i]);
			if (curWrapper == prevWrapper)
				continue;
			curWrapper = _setLineheight(curWrapper, height);
			prevWrapper = curWrapper;
		}
		endNode = curWrapper || startNode;
		setTimeout($Fn(function(startNode, endNode) {
			this.oSelection.setEndNodes(startNode, endNode);
			this.oSelection.select();
			this.oApp.exec("RECORD_UNDO_AFTER_ACTION", [ "LINEHEIGHT" ]);
		}, this).bind(startNode, endNode), 100);
	},
	_getSelectedNodes : function(bDontUpdate) {
		if (!bDontUpdate)
			this.oSelection = this.oApp.getSelection();
		if (this.oSelection.collapsed)
			this.oSelection.selectNode(this.oSelection.commonAncestorContainer);
		var nodes = this.oSelection.getTextNodes();
		if (nodes.length == 0) {
			var tmp = this.oSelection.getStartNode();
			if (tmp) {
				nodes[0] = tmp;
			} else {
				nodes = [];
			}
		}
		return nodes;
	},
	_getWrapperLineheight : function(div) {
		var iLineHeight = '';
		if (div && div.style.lineHeight) {
			iLineHeight = div.style.lineHeight;
		} else {
			div = this.oSelection.commonAncesterContainer;
			while (div && !this.oSelection.rxLineBreaker.test(div.tagName)) {
				if (div && div.style.lineHeight) {
					iLineHeight = div.style.lineHeight;
					break;
				}
				div = nhn.DOMFix.parentNode(div);
			}
		}
		return iLineHeight;
	},
	_isChildOf : function(node, container) {
		while (node && node.tagName != "BODY") {
			if (node == container)
				return true;
			node = nhn.DOMFix.parentNode(node);
		}
		return false;
	},
	_getLineWrapper : function(node) {
		var oTmpSelection = this.oApp.getEmptySelection();
		oTmpSelection.selectNode(node);
		var oLineInfo = oTmpSelection.getLineInfo();
		var oStart = oLineInfo.oStart;
		var oEnd = oLineInfo.oEnd;
		var a, b;
		var breakerA, breakerB;
		var div = null;
		a = oStart.oNode;
		breakerA = oStart.oLineBreaker;
		b = oEnd.oNode;
		breakerB = oEnd.oLineBreaker;
		this.oSelection.setEndNodes(a, b);
		if (breakerA == breakerB) {
			if (breakerA.tagName == "P" || breakerA.tagName == "DIV") {
				div = breakerA;
			} else {
				this.oSelection.setEndNodes(breakerA.firstChild,
						breakerA.lastChild);
			}
		}
		return div;
	}
});
nhn.husky.SE_LineHeightWithSelectUI = $Class(
		{
			name : "SE_LineHeightWithSelectUI",
			_assignHTMLObjects : function(elAppContainer) {
				this.elLineHeightSelect = cssquery.getSingle(
						"SELECT.husky_seditor_ui_lineHeight_select",
						elAppContainer);
			},
			$ON_MSG_APP_READY : function() {
				this.oApp.registerBrowserEvent(this.elLineHeightSelect,
						"change", "SET_LINEHEIGHT_FROM_SELECT_UI");
				this.elLineHeightSelect.selectedIndex = 0;
			},
			$ON_MSG_STYLE_CHANGED : function(sAttributeName, sAttributeValue) {
				if (sAttributeName == "lineHeight") {
					this.elLineHeightSelect.value = sAttributeValue;
					if (this.elLineHeightSelect.selectedIndex < 0)
						this.elLineHeightSelect.selectedIndex = 0;
				}
			},
			$ON_SET_LINEHEIGHT_FROM_SELECT_UI : function() {
				var nLineHeight = this.elLineHeightSelect.value;
				if (!nLineHeight)
					return;
				this.elLineHeightSelect.selectedIndex = 0;
				this.oApp.exec("SET_LINEHEIGHT", [ nLineHeight ]);
				this.oApp.exec("CHECK_STYLE_CHANGE", []);
			}
		}).extend(nhn.husky.SE_LineHeight);
nhn.husky.SE_ColorPalette = $Class({
	name : "SE_ColorPalette",
	rxRGBColorPattern : /rgb\((\d+), ?(\d+), ?(\d+)\)/i,
	$init : function(oAppContainer) {
		this._assignHTMLObjects(oAppContainer);
	},
	_assignHTMLObjects : function(oAppContainer) {
		this.elColorPaletteLayer = cssquery.getSingle(
				"UL.husky_seditor_color_palette", oAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.registerBrowserEvent(this.elColorPaletteLayer, "click",
				"EVENT_MOUSEUP_COLOR_PALETTE");
	},
	$ON_SHOW_COLOR_PALETTE : function(sCallbackCmd, oLayerContainer) {
		this.sCallbackCmd = sCallbackCmd;
		this.oLayerContainer = oLayerContainer;
		this.oLayerContainer.insertBefore(this.elColorPaletteLayer, null);
		this.elColorPaletteLayer.style.display = "block";
	},
	$ON_HIDE_COLOR_PALETTE : function() {
		this.elColorPaletteLayer.style.display = "none";
	},
	$ON_COLOR_PALETTE_APPLY_COLOR : function(sColorCode) {
		if (this.rxRGBColorPattern.test(sColorCode)) {
			function dec2Hex(sDec) {
				var sTmp = parseInt(sDec).toString(16);
				if (sTmp.length < 2)
					sTmp = "0" + sTmp;
				return sTmp.toUpperCase();
			}
			var sR = dec2Hex(RegExp.$1);
			var sG = dec2Hex(RegExp.$2);
			var sB = dec2Hex(RegExp.$3);
			sColorCode = "#" + sR + sG + sB;
		}
		this.oApp.exec(this.sCallbackCmd, [ sColorCode ]);
	},
	$ON_EVENT_MOUSEUP_COLOR_PALETTE : function(oEvent) {
		var elButton = oEvent.element;
		if (!elButton.style.backgroundColor)
			return;
		this.oApp.exec("COLOR_PALETTE_APPLY_COLOR",
				[ elButton.style.backgroundColor ]);
	}
});
nhn.husky.SE_FontColor = $Class({
	name : "SE_FontColor",
	rxColorPattern : /^#?[0-9a-fA-F]{6}$|^rgb\(\d+, ?\d+, ?\d+\)$/i,
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.elDropdownLayer = cssquery.getSingle(
				"DIV.husky_seditor_fontcolor_layer", elAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_UI_EVENT", [ "fontColor", "click",
				"TOGGLE_FONTCOLOR_LAYER" ]);
	},
	$ON_TOGGLE_FONTCOLOR_LAYER : function() {
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [ this.elDropdownLayer,
				null, "SHOW_COLOR_PALETTE",
				[ "APPLY_FONTCOLOR", this.elDropdownLayer ] ]);
		this.oSelection = this.oApp.getSelection();
	},
	$ON_APPLY_FONTCOLOR : function(sFontColor) {
		if (!this.rxColorPattern.test(sFontColor)) {
			alert(this.oApp.$MSG("SE_FontColor.invalidColorCode"));
			return;
		}
		this.oSelection.select();
		this.oApp.exec("SET_WYSIWYG_STYLE", [ {
			"color" : sFontColor
		} ]);
		this.oApp.exec("HIDE_ACTIVE_LAYER");
	}
});
nhn.husky.SE_BGColor = $Class({
	name : "SE_BGColor",
	rxColorPattern : /^#?[0-9a-fA-F]{6}$|^rgb\(\d+, ?\d+, ?\d+\)$/i,
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.elDropdownLayer = cssquery.getSingle(
				"DIV.husky_seditor_bgcolor_layer", elAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_UI_EVENT", [ "bgColor", "click",
				"TOGGLE_BGCOLOR_LAYER" ]);
		this.oApp.registerBrowserEvent(this.elDropdownLayer, "click",
				"EVENT_APPLY_BGCOLOR", []);
	},
	$ON_TOGGLE_BGCOLOR_LAYER : function() {
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [ this.elDropdownLayer,
				null, "SHOW_COLOR_PALETTE",
				[ "APPLY_BGCOLOR", this.elDropdownLayer ] ]);
		this.oSelection = this.oApp.getSelection();
	},
	$ON_EVENT_APPLY_BGCOLOR : function(weEvent) {
		var elButton = weEvent.element;
		if (elButton.tagName == "SPAN")
			elButton = elButton.parentNode;
		if (elButton.tagName != "BUTTON")
			return;
		var sBGColor, sFontColor;
		sBGColor = elButton.style.backgroundColor;
		sFontColor = elButton.style.color;
		this.oApp.exec("APPLY_BGCOLOR", [ sBGColor, sFontColor ]);
	},
	$ON_APPLY_BGCOLOR : function(sBGColor, sFontColor) {
		if (!this.rxColorPattern.test(sBGColor)) {
			alert(this.oApp.$MSG("SE_BGColor.invalidColorCode"));
			return;
		}
		this.oSelection.select();
		var oStyle = {
			"backgroundColor" : sBGColor
		}
		if (sFontColor)
			oStyle.color = sFontColor;
		this.oApp.exec("SET_WYSIWYG_STYLE", [ oStyle ]);
		this.oApp.exec("HIDE_ACTIVE_LAYER");
	}
});
nhn.husky.SE_Quote = $Class({
	name : "SE_Quote",
	requiredPlugin : [ "SE_EditingArea_WYSIWYG" ],
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.elDropdownLayer = cssquery.getSingle(
				"DIV.husky_seditor_blockquote_layer", elAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_UI_EVENT", [ "quote", "click",
				"TOGGLE_BLOCKQUOTE_LAYER" ]);
		this.oApp.registerBrowserEvent(this.elDropdownLayer, "click",
				"EVENT_APPLY_SEDITOR_BLOCKQUOTE", []);
	},
	$ON_TOGGLE_BLOCKQUOTE_LAYER : function() {
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [ this.elDropdownLayer ]);
	},
	$ON_EVENT_APPLY_SEDITOR_BLOCKQUOTE : function(weEvent) {
		var elButton = weEvent.element;
		if (elButton.tagName != "BUTTON")
			return;
		var sClass = elButton.parentNode.className;
		if (sClass != "q8")
			this._wrapBlock("BLOCKQUOTE", sClass);
		else
			this._unwrapBlock("BLOCKQUOTE");
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	},
	_unwrapBlock : function(tag) {
		var oSelection = this.oApp.getSelection();
		var oC = oSelection.commonAncestorContainer;
		while (oC && oC.tagName != tag)
			oC = oC.parentNode;
		if (!oC)
			return;
		while (oC.firstChild)
			oC.parentNode.insertBefore(oC.firstChild, oC);
		oC.parentNode.removeChild(oC);
	},
	_wrapBlock : function(tag, className) {
		var oSelection = this.oApp.getSelection();
		var oLineInfo = oSelection.getLineInfo();
		var oStart = oLineInfo.oStart;
		var oEnd = oLineInfo.oEnd;
		var rxDontUseAsWhole = /BODY|TD|LI/i;
		var oStartNode, oEndNode;
		if (oStart.bParentBreak
				&& !rxDontUseAsWhole.test(oStart.oLineBreaker.tagName))
			oStartNode = oStart.oNode.parentNode;
		else
			oStartNode = oStart.oNode;
		if (oEnd.bParentBreak
				&& !rxDontUseAsWhole.test(oEnd.oLineBreaker.tagName))
			oEndNode = oEnd.oNode.parentNode;
		else
			oEndNode = oEnd.oNode;
		oSelection.setStartBefore(oStartNode);
		oSelection.setEndAfter(oEndNode);
		var oNode = this._expandToTableStart(oSelection, oEndNode);
		if (oNode) {
			oEndNode = oNode;
			oSelection.setEndAfter(oNode);
		}
		oNode = this._expandToTableStart(oSelection, oStartNode);
		if (oNode) {
			oStartNode = oNode;
			oSelection.setStartBefore(oNode);
		}
		oNode = oStartNode;
		var oC = oSelection.commonAncestorContainer;
		while (oNode && oNode != oC && oNode.parentNode != oC)
			oNode = oNode.parentNode;
		oFormattingNode = oSelection._document.createElement(tag);
		if (className)
			oFormattingNode.className = className;
		if (oNode == oC) {
			oC.insertBefore(oFormattingNode, oC.firstChild);
		} else {
			oC.insertBefore(oFormattingNode, oNode);
		}
		oSelection.setStartAfter(oFormattingNode);
		oSelection.setEndAfter(oEndNode);
		oSelection.surroundContents(oFormattingNode);
		var aNodes = oFormattingNode.childNodes;
		var oInsertionPoint;
		for (var i = aNodes.length - 1; i >= 0; i--) {
			if (aNodes[i].nodeType == 3 || aNodes[i].tagName == "BR") {
				var oP = oSelection._document.createElement("P");
				oInsertionPoint = aNodes[i].nextSibling;
				while (i >= 0
						&& aNodes[i]
						&& (aNodes[i].nodeType == 3 || aNodes[i].tagName == "BR")) {
					oP.insertBefore(aNodes[i--], oP.firstChild);
				}
				oFormattingNode.insertBefore(oP, oInsertionPoint);
				i++;
			}
		}
		if (oFormattingNode && oFormattingNode.parentNode) {
			var oP = oSelection._document.createElement("P");
			oP.innerHTML = unescape("<br/>");
			oFormattingNode.parentNode.insertBefore(oP,
					oFormattingNode.nextSibling);
		}
		this.oApp.exec("RECORD_UNDO_ACTION", [ "Block Quote" ]);
		return oFormattingNode;
	},
	_expandToTableStart : function(oSelection, oNode) {
		var oC = oSelection.commonAncestorContainer;
		var oResultNode = null;
		var bLastIteration = false;
		while (oNode && !bLastIteration) {
			if (oNode == oC)
				bLastIteration = true;
			if (/TBODY|TFOOT|THEAD|TR/i.test(oNode.tagName)) {
				oResultNode = this._getTableRoot(oNode);
				break;
			}
			oNode = oNode.parentNode;
		}
		return oResultNode;
	},
	_getTableRoot : function(oNode) {
		while (oNode && oNode.tagName != "TABLE")
			oNode = oNode.parentNode;
		return oNode;
	}
});
nhn.husky.SE_SCharacter = $Class({
	name : "SE_SCharacter",
	requiredPlugin : [ "HuskyRangeManager" ],
	$init : function(oAppContainer) {
		this.bIE = $Agent().navigator().ie;
		this._assignHTMLObjects(oAppContainer);
		this.charSet = [];
		this.charSet[0] = unescape(
				'FF5B FF5D 3014 3015 3008 3009 300A 300B 300C 300D 300E 300F 3010 3011 2018 2019 201C 201D 3001 3002 %B7 2025 2026 %A7 203B 2606 2605 25CB 25CF 25CE 25C7 25C6 25A1 25A0 25B3 25B2 25BD 25BC 25C1 25C0 25B7 25B6 2664 2660 2661 2665 2667 2663 2299 25C8 25A3 25D0 25D1 2592 25A4 25A5 25A8 25A7 25A6 25A9 %B1 %D7 %F7 2260 2264 2265 221E 2234 %B0 2032 2033 2220 22A5 2312 2202 2261 2252 226A 226B 221A 223D 221D 2235 222B 222C 2208 220B 2286 2287 2282 2283 222A 2229 2227 2228 FFE2 21D2 21D4 2200 2203 %B4 FF5E 02C7 02D8 02DD 02DA 02D9 %B8 02DB %A1 %BF 02D0 222E 2211 220F 266D 2669 266A 266C 327F 2192 2190 2191 2193 2194 2195 2197 2199 2196 2198 321C 2116 33C7 2122 33C2 33D8 2121 2668 260F 260E 261C 261E %B6 2020 2021 %AE %AA %BA 2642 2640')
				.replace(/(\S{4})/g, function(a) {
					return "%u" + a
				}).split(' ');
		this.charSet[1] = unescape(
				'%BD 2153 2154 %BC %BE 215B 215C 215D 215E %B9 %B2 %B3 2074 207F 2081 2082 2083 2084 2160 2161 2162 2163 2164 2165 2166 2167 2168 2169 2170 2171 2172 2173 2174 2175 2176 2177 2178 2179 FFE6 %24 FFE5 FFE1 20AC 2103 212B 2109 FFE0 %A4 2030 3395 3396 3397 2113 3398 33C4 33A3 33A4 33A5 33A6 3399 339A 339B 339C 339D 339E 339F 33A0 33A1 33A2 33CA 338D 338E 338F 33CF 3388 3389 33C8 33A7 33A8 33B0 33B1 33B2 33B3 33B4 33B5 33B6 33B7 33B8 33B9 3380 3381 3382 3383 3384 33BA 33BB 33BC 33BD 33BE 33BF 3390 3391 3392 3393 3394 2126 33C0 33C1 338A 338B 338C 33D6 33C5 33AD 33AE 33AF 33DB 33A9 33AA 33AB 33AC 33DD 33D0 33D3 33C3 33C9 33DC 33C6')
				.replace(/(\S{4})/g, function(a) {
					return "%u" + a
				}).split(' ');
		this.charSet[2] = unescape(
				'3260 3261 3262 3263 3264 3265 3266 3267 3268 3269 326A 326B 326C 326D 326E 326F 3270 3271 3272 3273 3274 3275 3276 3277 3278 3279 327A 327B 24D0 24D1 24D2 24D3 24D4 24D5 24D6 24D7 24D8 24D9 24DA 24DB 24DC 24DD 24DE 24DF 24E0 24E1 24E2 24E3 24E4 24E5 24E6 24E7 24E8 24E9 2460 2461 2462 2463 2464 2465 2466 2467 2468 2469 246A 246B 246C 246D 246E 3200 3201 3202 3203 3204 3205 3206 3207 3208 3209 320A 320B 320C 320D 320E 320F 3210 3211 3212 3213 3214 3215 3216 3217 3218 3219 321A 321B 249C 249D 249E 249F 24A0 24A1 24A2 24A3 24A4 24A5 24A6 24A7 24A8 24A9 24AA 24AB 24AC 24AD 24AE 24AF 24B0 24B1 24B2 24B3 24B4 24B5 2474 2475 2476 2477 2478 2479 247A 247B 247C 247D 247E 247F 2480 2481 2482')
				.replace(/(\S{4})/g, function(a) {
					return "%u" + a
				}).split(' ');
		this.charSet[3] = unescape(
				'3131 3132 3133 3134 3135 3136 3137 3138 3139 313A 313B 313C 313D 313E 313F 3140 3141 3142 3143 3144 3145 3146 3147 3148 3149 314A 314B 314C 314D 314E 314F 3150 3151 3152 3153 3154 3155 3156 3157 3158 3159 315A 315B 315C 315D 315E 315F 3160 3161 3162 3163 3165 3166 3167 3168 3169 316A 316B 316C 316D 316E 316F 3170 3171 3172 3173 3174 3175 3176 3177 3178 3179 317A 317B 317C 317D 317E 317F 3180 3181 3182 3183 3184 3185 3186 3187 3188 3189 318A 318B 318C 318D 318E')
				.replace(/(\S{4})/g, function(a) {
					return "%u" + a
				}).split(' ');
		this.charSet[4] = unescape(
				'0391 0392 0393 0394 0395 0396 0397 0398 0399 039A 039B 039C 039D 039E 039F 03A0 03A1 03A3 03A4 03A5 03A6 03A7 03A8 03A9 03B1 03B2 03B3 03B4 03B5 03B6 03B7 03B8 03B9 03BA 03BB 03BC 03BD 03BE 03BF 03C0 03C1 03C3 03C4 03C5 03C6 03C7 03C8 03C9 %C6 %D0 0126 0132 013F 0141 %D8 0152 %DE 0166 014A %E6 0111 %F0 0127 I 0133 0138 0140 0142 0142 0153 %DF %FE 0167 014B 0149 0411 0413 0414 0401 0416 0417 0418 0419 041B 041F 0426 0427 0428 0429 042A 042B 042C 042D 042E 042F 0431 0432 0433 0434 0451 0436 0437 0438 0439 043B 043F 0444 0446 0447 0448 0449 044A 044B 044C 044D 044E 044F')
				.replace(/(\S{4})/g, function(a) {
					return "%u" + a
				}).split(' ');
		this.charSet[5] = unescape(
				'3041 3042 3043 3044 3045 3046 3047 3048 3049 304A 304B 304C 304D 304E 304F 3050 3051 3052 3053 3054 3055 3056 3057 3058 3059 305A 305B 305C 305D 305E 305F 3060 3061 3062 3063 3064 3065 3066 3067 3068 3069 306A 306B 306C 306D 306E 306F 3070 3071 3072 3073 3074 3075 3076 3077 3078 3079 307A 307B 307C 307D 307E 307F 3080 3081 3082 3083 3084 3085 3086 3087 3088 3089 308A 308B 308C 308D 308E 308F 3090 3091 3092 3093 30A1 30A2 30A3 30A4 30A5 30A6 30A7 30A8 30A9 30AA 30AB 30AC 30AD 30AE 30AF 30B0 30B1 30B2 30B3 30B4 30B5 30B6 30B7 30B8 30B9 30BA 30BB 30BC 30BD 30BE 30BF 30C0 30C1 30C2 30C3 30C4 30C5 30C6 30C7 30C8 30C9 30CA 30CB 30CC 30CD 30CE 30CF 30D0 30D1 30D2 30D3 30D4 30D5 30D6 30D7 30D8 30D9 30DA 30DB 30DC 30DD 30DE 30DF 30E0 30E1 30E2 30E3 30E4 30E5 30E6 30E7 30E8 30E9 30EA 30EB 30EC 30ED 30EE 30EF 30F0 30F1 30F2 30F3 30F4 30F5 30F6')
				.replace(/(\S{4})/g, function(a) {
					return "%u" + a
				}).split(' ');
	},
	_assignHTMLObjects : function(oAppContainer) {
		oAppContainer = $(oAppContainer) || document;
		this.elDropdownLayer = cssquery.getSingle(
				"DIV.husky_seditor_sCharacter_layer", oAppContainer);
		this.oTextField = cssquery.getSingle("INPUT", this.elDropdownLayer);
		this.oInsertButton = cssquery.getSingle("+ BUTTON", this.oTextField);
		this.aCloseButton = cssquery("BUTTON.close", this.elDropdownLayer);
		this.aSCharList = cssquery(".list", this.elDropdownLayer);
		var oLabelUL = cssquery.getSingle(">UL", this.elDropdownLayer);
		this.aLabelA = cssquery("A", oLabelUL);
	},
	$ON_MSG_APP_READY : function() {
		var funcInsert = $Fn(this.oApp.exec, this.oApp).bind(
				"INSERT_SCHARACTERS", [ this.oTextField.value ]);
		$Fn(funcInsert, this).attach(this.oInsertButton, "click");
		this.oApp.exec("SET_SCHARACTER_LIST", [ this.charSet ]);
		for (var i = 0; i < this.aLabelA.length; i++) {
			var func = $Fn(this.oApp.exec, this.oApp).bind(
					"CHANGE_SCHARACTER_SET", [ i ]);
			$Fn(func, this).attach(this.aLabelA[i], "mousedown");
			this.oApp.stopBrowserEvent(this.aLabelA[i], "click");
		}
		for (var i = 0; i < this.aCloseButton.length; i++) {
			this.oApp.registerBrowserEvent(this.aCloseButton[i], "click",
					"HIDE_ACTIVE_LAYER", []);
		}
		this.oApp.registerBrowserEvent(this.elDropdownLayer, "click",
				"EVENT_SCHARACTER_CLICKED", []);
		this.oApp.exec("REGISTER_UI_EVENT", [ "sCharacter", "click",
				"TOGGLE_SCHARACTER_LAYER" ]);
	},
	$ON_TOGGLE_SCHARACTER_LAYER : function() {
		this.oTextField.value = "";
		this.oSelection = this.oApp.getSelection();
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [ this.elDropdownLayer ]);
	},
	$ON_EVENT_SCHARACTER_CLICKED : function(weEvent) {
		var elButton = weEvent.element;
		if (elButton.tagName != "BUTTON")
			return;
		if (elButton.parentNode.tagName != "LI")
			return;
		var sChar = elButton.firstChild.innerHTML;
		this.oApp.exec("SELECT_SCHARACTER", [ sChar ]);
	},
	$ON_SELECT_SCHARACTER : function(schar) {
		this.oTextField.value += schar;
		if (this.oTextField.createTextRange) {
			var oTextRange = this.oTextField.createTextRange();
			oTextRange.collapse(false);
			oTextRange.select();
		} else {
			if (this.oTextField.selectionEnd) {
				this.oTextField.selectionEnd = this.oTextField.value.length;
				this.oTextField.focus();
			}
		}
	},
	$ON_INSERT_SCHARACTERS : function() {
		this.oSelection.pasteHTML(this.oTextField.value);
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	},
	$ON_CHANGE_SCHARACTER_SET : function(nSCharSet) {
		for (var i = 0; i < this.aSCharList.length; i++) {
			if (this.aSCharList[i].style.display == "block") {
				if (i == nSCharSet)
					return;
				$Element(this.aLabelA[i]).removeClass("on");
				this.aSCharList[i].style.display = "none";
			}
		}
		this._drawSCharList(nSCharSet);
		$Element(this.aLabelA[nSCharSet]).addClass("on");
		this.aSCharList[nSCharSet].style.display = "block";
	},
	$ON_SET_SCHARACTER_LIST : function(charSet) {
		this.charSet = charSet;
		this.bSCharSetDrawn = new Array(this.charSet.length);
		this._drawSCharList(0);
	},
	_drawSCharList : function(i) {
		if (this.bSCharSetDrawn[i])
			return;
		this.bSCharSetDrawn[i] = true;
		var len = this.charSet[i].length;
		var aLI = new Array(len);
		this.aSCharList[i].innerHTML = '';
		var button, span;
		for (var ii = 0; ii < len; ii++) {
			aLI[ii] = document.createElement("LI");
			if (this.bIE) {
				button = document.createElement("<BUTTON type='button'>");
			} else {
				button = document.createElement("BUTTON");
				button.type = "button";
			}
			span = document.createElement("SPAN");
			span.innerHTML = unescape(this.charSet[i][ii]);
			button.appendChild(span);
			aLI[ii].appendChild(button);
			this.aSCharList[i].appendChild(aLI[ii]);
		}
	}
});
nhn.husky.SE_UndoRedo = $Class({
	name : "SE_UndoRedo",
	requiredPlugin : [ "SE_EditingAreaManager", "HuskyRangeManager" ],
	actionHistory : null,
	oCurStateIdx : null,
	iMinimumSizeChange : 10,
	sBlankContentsForFF : "<br>",
	$init : function() {
		this.actionHistory = [];
		this.oCurStateIdx = {
			nIdx : 0,
			nStep : 0
		};
	},
	$PRECONDITION : function() {
		try {
			if (this.oApp.getEditingMode() != "WYSIWYG")
				return false;
		} catch (e) {
			return false;
		}
		return true;
	},
	$BEFORE_MSG_APP_READY : function() {
		this._add_undo_history_at(this.oCurStateIdx, "", "", null);
	},
	$ON_MSG_APP_READY : function() {
		this.bFF = this.oApp.oNavigatorInfo.firefox;
		this.oApp.exec("DISABLE_UI", [ "undo" ]);
		this.oApp.exec("DISABLE_UI", [ "redo" ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "undo", "click", "UNDO" ]);
		this.oApp.exec("REGISTER_UI_EVENT", [ "redo", "click", "REDO" ]);
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+z", "UNDO" ]);
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+y", "REDO" ]);
	},
	$ON_UNDO : function() {
		var oTmpStateIdx = {};
		this._add_undo_history("KEYPRESS", false, false, true);
		if (this.oCurStateIdx.nIdx == 0)
			return;
		if (this.oCurStateIdx.nStep > 0) {
			this.oCurStateIdx.nStep--;
		} else {
			var oTmpHistory = this.actionHistory[this.oCurStateIdx.nIdx];
			this.oCurStateIdx.nIdx--;
			if (oTmpHistory.nTotalSteps > 1) {
				this.oCurStateIdx.nStep = 0;
			} else {
				oTmpHistory = this.actionHistory[this.oCurStateIdx.nIdx];
				this.oCurStateIdx.nStep = oTmpHistory.nTotalSteps - 1;
			}
		}
		this._retrieveHistory();
		if (this.oCurStateIdx.nIdx <= 0)
			this.oApp.exec("DISABLE_UI", [ "undo" ]);
		this.oApp.exec("ENABLE_UI", [ "redo" ]);
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	},
	$ON_REDO : function() {
		if (this.oCurStateIdx.nIdx >= this.actionHistory.length)
			return;
		var oCurHistory = this.actionHistory[this.oCurStateIdx.nIdx];
		if (this.oCurStateIdx.nIdx == this.actionHistory.length - 1
				&& this.oCurStateIdx.nStep >= oCurHistory.nTotalSteps - 1)
			return;
		if (this.oCurStateIdx.nStep < oCurHistory.nTotalSteps - 1) {
			this.oCurStateIdx.nStep++;
		} else {
			this.oCurStateIdx.nIdx++;
			oCurHistory = this.actionHistory[this.oCurStateIdx.nIdx];
			this.oCurStateIdx.nStep = oCurHistory.nTotalSteps - 1;
		}
		this._retrieveHistory();
		this.oApp.exec("ENABLE_UI", [ "undo" ]);
		if (this.oCurStateIdx.nIdx >= this.actionHistory.length)
			this.oApp.exec("DISABLE_UI", [ "redo" ]);
		this.oApp.exec("CHECK_STYLE_CHANGE", []);
	},
	$ON_RECORD_UNDO_ACTION : function(sAction) {
		this._add_undo_history(sAction);
	},
	$ON_RECORD_UNDO_ACTION_FORCED : function(sAction) {
		this._add_undo_history(sAction, false, false, true);
	},
	$ON_RECORD_UNDO_BEFORE_ACTION : function(sAction) {
		this._add_undo_history(sAction, true, true);
	},
	$ON_RECORD_UNDO_AFTER_ACTION : function(sAction) {
		this._add_undo_history(sAction, true, false);
	},
	_retrieveHistory : function() {
		var oCurHistory = this.actionHistory[this.oCurStateIdx.nIdx];
		var sContent = oCurHistory.sContent[this.oCurStateIdx.nStep];
		var oBookmark = oCurHistory.oBookmark[this.oCurStateIdx.nStep];
		this.oApp.setIR(sContent, true);
		var sCurContent = this.oApp.getIR();
		if (this.bFF && sCurContent == this.sBlankContentsForFF) {
			sCurContent = "";
		}
		oCurHistory.sContent[this.oCurStateIdx.nStep] = sCurContent;
		var oSelection = this.oApp.getEmptySelection();
		if (oSelection.selectionLoaded) {
			if (oBookmark) {
				oSelection.moveToXPathBookmark(oBookmark);
			} else {
				oSelection = this.oApp.getEmptySelection();
			}
			oSelection.select();
		}
	},
	_add_undo_history : function(sAction, bTwoStepAction, bBeforeAction,
			bForceAddUnlessEqual) {
		bTwoStepAction = bTwoStepAction || false;
		bBeforeAction = bBeforeAction || false;
		bForceAddUnlessEqual = bForceAddUnlessEqual || false;
		if (!(this.oCurStateIdx.nIdx == this.actionHistory.length - 1))
			bForceAddUnlessEqual = true;
		var oCurHistory = this.actionHistory[this.oCurStateIdx.nIdx];
		var sCurContent = this.oApp.getIR();
		var sHistoryContent = oCurHistory.sContent[this.oCurStateIdx.nStep];
		if (this.bFF && sCurContent == this.sBlankContentsForFF) {
			sCurContent = "";
		}
		if (!bTwoStepAction) {
			if (bForceAddUnlessEqual) {
				if (sHistoryContent == sCurContent)
					return false;
			} else {
				if (Math.abs(sHistoryContent.length - sCurContent.length) < this.iMinimumSizeChange)
					return false;
			}
		}
		var oSelection = this.oApp.getSelection();
		var oBookmark = null;
		if (oSelection.selectionLoaded) {
			oBookmark = oSelection.getXPathBookmark();
		}
		var oInsertionIdx = {
			nIdx : this.oCurStateIdx.nIdx,
			nStep : this.oCurStateIdx.nStep
		};
		if (bTwoStepAction) {
			if (bBeforeAction) {
				oInsertionIdx.nStep = 0;
			} else {
				oInsertionIdx.nStep = 1;
			}
		} else {
			oInsertionIdx.nStep = 0;
		}
		if (oInsertionIdx.nStep == 0
				&& this.oCurStateIdx.nStep == oCurHistory.nTotalSteps - 1) {
			oInsertionIdx.nIdx = this.oCurStateIdx.nIdx + 1;
		}
		return this._add_undo_history_at(oInsertionIdx, sAction, sCurContent,
				oBookmark);
	},
	_add_undo_history_at : function(oInsertionIdx, sAction, sContent, oBookmark) {
		if (oInsertionIdx.nStep != 0) {
			this.actionHistory[oInsertionIdx.nIdx].nTotalSteps = oInsertionIdx.nStep + 1;
			this.actionHistory[oInsertionIdx.nIdx].sContent[oInsertionIdx.nStep] = sContent;
			this.actionHistory[oInsertionIdx.nIdx].oBookmark[oInsertionIdx.nStep] = oBookmark;
		} else {
			var oNewHistory = {
				sAction : sAction,
				nTotalSteps : 1
			};
			oNewHistory.sContent = [];
			oNewHistory.sContent[0] = sContent;
			oNewHistory.oBookmark = [];
			oNewHistory.oBookmark[0] = oBookmark;
			this.actionHistory
					.splice(oInsertionIdx.nIdx, this.actionHistory.length
							- oInsertionIdx.nIdx, oNewHistory);
		}
		this.oCurStateIdx.nIdx = oInsertionIdx.nIdx;
		this.oCurStateIdx.nStep = oInsertionIdx.nStep;
		this.oApp.exec("ENABLE_UI", [ "undo" ]);
		this.oApp.exec("DISABLE_UI", [ "redo" ]);
		return true;
	}
});
nhn.husky.SE_FindReplacePlugin = $Class({
	name : "SE_FindReplacePlugin",
	oEditingWindow : null,
	oFindReplace : null,
	oUILayer : null,
	bFindMode : true,
	$init : function(oAppContainer) {
		this._assignHTMLObjects(oAppContainer);
	},
	_assignHTMLObjects : function(oAppContainer) {
		oAppContainer = $(oAppContainer) || document;
		this.oEditingWindow = cssquery.getSingle("IFRAME", oAppContainer);
		this.oUILayer = cssquery.getSingle(
				"DIV.husky_seditor_findAndReplace_layer", oAppContainer);
		var oTmp = cssquery("LI", this.oUILayer);
		this.oFindTab = oTmp[0];
		this.oReplaceTab = oTmp[1];
		oTmp = cssquery(".container > .bx", this.oUILayer);
		this.oFindInputSet = oTmp[0];
		this.oReplaceInputSet = oTmp[1];
		this.oFindInput_Keyword = cssquery.getSingle("INPUT",
				this.oFindInputSet);
		oTmp = cssquery("INPUT", this.oReplaceInputSet);
		this.oReplaceInput_Original = oTmp[0];
		this.oReplaceInput_Replacement = oTmp[1];
		this.oFindNextButton = cssquery.getSingle("BUTTON.find_next",
				this.oUILayer);
		this.oCancelButton = cssquery.getSingle("BUTTON.cancel", this.oUILayer);
		this.oReplaceButton = cssquery.getSingle("BUTTON.replace",
				this.oUILayer);
		this.oReplaceAllButton = cssquery.getSingle("BUTTON.replace_all",
				this.oUILayer);
		this.aCloseButtons = cssquery("BUTTON.close", this.oUILayer);
		this.aCloseButtons[this.aCloseButtons.length] = this.oCancelButton;
	},
	$ON_MSG_APP_READY : function() {
		if (this.oEditingWindow && this.oEditingWindow.tagName == "IFRAME")
			this.oEditingWindow = this.oEditingWindow.contentWindow;
		this.oFindReplace = new nhn.FindReplace(this.oEditingWindow);
		if (!this.oFindReplace.bBrowserSupported) {
			this.oApp.exec("DISABLE_UI", [ "find_replace" ]);
			return;
		}
		for (var i = 0; i < this.aCloseButtons.length; i++) {
			var func = $Fn(this.oApp.exec, this.oApp).bind("HIDE_DIALOG_LAYER",
					[ this.oUILayer ]);
			$Fn(func, this).attach(this.aCloseButtons[i], "click");
		}
		$Fn($Fn(this.oApp.exec, this.oApp).bind("SHOW_FIND", []), this).attach(
				this.oFindTab, "mousedown");
		$Fn($Fn(this.oApp.exec, this.oApp).bind("SHOW_REPLACE", []), this)
				.attach(this.oReplaceTab, "mousedown");
		$Fn($Fn(this.oApp.exec, this.oApp).bind("FIND", []), this).attach(
				this.oFindNextButton, "click");
		$Fn($Fn(this.oApp.exec, this.oApp).bind("REPLACE", []), this).attach(
				this.oReplaceButton, "click");
		$Fn($Fn(this.oApp.exec, this.oApp).bind("REPLACE_ALL", []), this)
				.attach(this.oReplaceAllButton, "click");
		this.oApp.exec("REGISTER_UI_EVENT", [ "findAndReplace", "click",
				"SHOW_FIND_REPLACE_LAYER" ]);
	},
	$ON_SHOW_ACTIVE_LAYER : function() {
		this.oApp.exec("HIDE_DIALOG_LAYER", [ this.oUILayer ]);
	},
	$ON_SHOW_FIND_REPLACE_LAYER : function() {
		this.oApp.exec("SHOW_DIALOG_LAYER", [ this.oUILayer ]);
		this.oApp.exec("POSITION_TOOLBAR_LAYER", [ this.oUILayer ]);
		this.oApp.exec("HIDE_CURRENT_ACTIVE_LAYER", []);
	},
	$ON_SHOW_FIND : function() {
		this.bFindMode = true;
		$Element(this.oFindTab).addClass("on");
		$Element(this.oReplaceTab).removeClass("on");
		$Element(this.oFindNextButton).removeClass("normal");
		$Element(this.oFindNextButton).addClass("strong");
		this.oFindInputSet.style.display = "block";
		this.oReplaceInputSet.style.display = "none";
		this.oReplaceButton.style.display = "none";
		this.oReplaceAllButton.style.display = "none";
		$Element(this.oUILayer).removeClass("replace");
		$Element(this.oUILayer).addClass("find");
		this.oFindInput_Keyword.value = this.oReplaceInput_Original.value;
	},
	$ON_SHOW_REPLACE : function() {
		this.bFindMode = false;
		$Element(this.oFindTab).removeClass("on");
		$Element(this.oReplaceTab).addClass("on");
		$Element(this.oFindNextButton).removeClass("strong");
		$Element(this.oFindNextButton).addClass("normal");
		this.oFindInputSet.style.display = "none";
		this.oReplaceInputSet.style.display = "block";
		this.oReplaceButton.style.display = "inline";
		this.oReplaceAllButton.style.display = "inline";
		$Element(this.oUILayer).removeClass("find");
		$Element(this.oUILayer).addClass("replace");
		this.oReplaceInput_Original.value = this.oFindInput_Keyword.value;
	},
	$ON_FIND : function() {
		var sKeyword;
		if (this.bFindMode)
			sKeyword = this.oFindInput_Keyword.value;
		else
			sKeyword = this.oReplaceInput_Original.value;
		switch (this.oFindReplace.find(sKeyword, false)) {
		case 1:
			alert(this.oApp.$MSG("SE_FindReplace.keywordNotFound"));
			break;
		case 2:
			alert(this.oApp.$MSG("SE_FindReplace.keywordMissing"));
			break;
		}
	},
	$ON_REPLACE : function() {
		var sOriginal = this.oReplaceInput_Original.value;
		var sReplacement = this.oReplaceInput_Replacement.value;
		this.oApp.exec("RECORD_UNDO_BEFORE_ACTION", [ "REPLACE" ]);
		var iReplaceResult = this.oFindReplace.replace(sOriginal, sReplacement,
				false);
		this.oApp.exec("RECORD_UNDO_AFTER_ACTION", [ "REPLACE" ]);
		switch (iReplaceResult) {
		case 1:
		case 3:
			alert(this.oApp.$MSG("SE_FindReplace.keywordNotFound"));
			break;
		case 4:
			alert(this.oApp.$MSG("SE_FindReplace.keywordMissing"));
			break;
		}
	},
	$ON_REPLACE_ALL : function() {
		var sOriginal = this.oReplaceInput_Original.value;
		var sReplacement = this.oReplaceInput_Replacement.value;
		this.oApp.exec("RECORD_UNDO_BEFORE_ACTION", [ "REPLACE ALL" ]);
		var iReplaceAllResult = this.oFindReplace.replaceAll(sOriginal,
				sReplacement, false);
		this.oApp.exec("RECORD_UNDO_AFTER_ACTION", [ "REPLACE ALL" ]);
		if (iReplaceAllResult < 0) {
			alert(this.oApp.$MSG("SE_FindReplace.keywordMissing"));
		} else {
			alert(this.oApp.$MSG("SE_FindReplace.replaceAllResultP1")
					+ iReplaceAllResult
					+ this.oApp.$MSG("SE_FindReplace.replaceAllResultP2"));
		}
	}
});
nhn.husky.SE_FileUpload = $Class({
	name : "SE_FileUpload",
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.oFileUploadLayer = cssquery.getSingle(
				"DIV.husky_seditor_fileupload_layer", elAppContainer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_UI_EVENT", [ "fileupload", "click",
				"SE_TOGGLE_FILEUPLOAD_LAYER" ]);
	},
	$ON_SE_TOGGLE_FILEUPLOAD_LAYER : function() {
		this.oApp
				.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [ this.oFileUploadLayer ]);
	}
});
nhn.husky.SE_Hyperlink = $Class({
	name : "SE_Hyperlink",
	sATagMarker : "HTTP://HUSKY_TMP.MARKER/",
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
		this.sRXATagMarker = this.sATagMarker.replace(/\//g, "\\/").replace(
				/\./g, "\\.");
	},
	_assignHTMLObjects : function(elAppContainer) {
		this.oHyperlinkLayer = cssquery.getSingle(
				"DIV.husky_seditor_hyperlink_layer", elAppContainer);
		this.oLinkInput = cssquery.getSingle("INPUT[type=text]",
				this.oHyperlinkLayer);
		this.oBtnConfirm = cssquery.getSingle("BUTTON.confirm",
				this.oHyperlinkLayer);
		this.oBtnCancel = cssquery.getSingle("BUTTON.cancel",
				this.oHyperlinkLayer);
		this.oCbNewWin = cssquery.getSingle("INPUT[type=checkbox]",
				this.oHyperlinkLayer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_HOTKEY", [ "ctrl+k",
				"SE_TOGGLE_HYPERLINK_LAYER", [] ]);
		this.oApp.registerBrowserEvent(this.oBtnConfirm, "mousedown",
				"SE_APPLY_HYPERLINK");
		this.oApp.registerBrowserEvent(this.oBtnCancel, "mousedown",
				"HIDE_ACTIVE_LAYER");
		this.oApp.registerBrowserEvent(this.oLinkInput, "keydown",
				"EVENT_SE_HYPERLINK_KEYDOWN");
		this.oApp.exec("REGISTER_UI_EVENT", [ "hyperlink", "click",
				"SE_TOGGLE_HYPERLINK_LAYER" ]);
	},
	$ON_SE_TOGGLE_HYPERLINK_LAYER : function() {
		this.oApp
				.delayedExec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [
						this.oHyperlinkLayer, null, "SE_RESET_HYPERLINK_LAYER",
						[] ], 0);
	},
	$ON_SE_RESET_HYPERLINK_LAYER : function() {
		this.oSelection = this.oApp.getSelection();
		var oAnchor = this.oSelection.findAncestorByTagName("A");
		this.oCbNewWin.checked = false;
		if (oAnchor) {
			this.oSelection.selectNode(oAnchor);
			this.oSelection.select();
			var sTarget = oAnchor.target;
			if (sTarget && sTarget == "_blank")
				this.oCbNewWin.checked = true;
			this.oLinkInput.value = oAnchor.href ? oAnchor.href : "http://";
		} else {
			this.oLinkInput.value = "http://";
		}
		this.oLinkInput.focus();
		this.oLinkInput.value = this.oLinkInput.value;
	},
	$ON_SE_APPLY_HYPERLINK : function() {
		var sURL = this.oLinkInput.value;
		this.oSelection.select();
		if (this._validateURL(sURL)) {
			var sTarget = "";
			if (this.oCbNewWin.checked)
				sTarget = "_blank";
			else
				sTarget = "_self";
			if (this.oSelection.collapsed) {
				var str = "<a href='" + sURL + "' target=" + sTarget + ">"
						+ sURL + "</a>";
				this.oSelection.pasteHTML(str);
			} else {
				var nSession = Math.ceil(Math.random() * 10000);
				var arg = (sURL == "" ? [ "unlink" ] : [ "createLink", false,
						this.sATagMarker + nSession + sURL ]);
				this.oApp.exec("EXECCOMMAND", arg);
				this.oSelection.setFromSelection();
				var oDoc = this.oApp.getWYSIWYGDocument();
				var aATags = oDoc.body.getElementsByTagName("A");
				var nLen = aATags.length;
				var rxMarker = new RegExp(this.sRXATagMarker + nSession, "i");
				var elATag;
				for (var i = 0; i < nLen; i++) {
					elATag = aATags[i];
					if (elATag.href && elATag.href.match(rxMarker)) {
						elATag.href = elATag.href.replace(rxMarker, "");
						elATag.target = sTarget;
					}
				}
			}
			this.oApp.exec("HIDE_ACTIVE_LAYER");
			setTimeout($Fn(function() {
				this.oSelection.select()
			}, this).bind(this), 0);
		} else {
			alert(this.oApp.$MSG("SE_Hyperlink.invalidURL"));
			this.oLinkInput.focus();
		}
	},
	_validateURL : function(sURL) {
		return /^(http|https|ftp|mailto):(?:\/\/)?((\w|-)+(?:[\.:@](\w|-))+)(?:\/|@)?([^"\?]*?)(?:\?([^\?"]*?))?$/
				.test(sURL);
	},
	$ON_EVENT_SE_HYPERLINK_KEYDOWN : function(oEvent) {
		if (oEvent.key().enter) {
			this.oApp.exec("SE_APPLY_HYPERLINK");
			oEvent.stop();
		}
	}
});
nhn.husky.SE_Table = $Class({
	name : "SE_Table",
	iMinRows : 1,
	iMaxRows : 20,
	iMinColumns : 1,
	iMaxColumns : 10,
	iMinBorderWidth : 1,
	iMaxBorderWidth : 10,
	oInsertionPointBookmark : null,
	oSelection : null,
	$init : function(oAppContainer) {
		this._assignHTMLObjects(oAppContainer);
	},
	_assignHTMLObjects : function(oAppContainer) {
		var tmp = null;
		this.elDropdownLayer = cssquery.getSingle(
				"DIV.husky_seditor_table_layer", oAppContainer);
		this.welDropdownLayer = $Element(this.elDropdownLayer);
		tmp = cssquery("INPUT", this.elDropdownLayer);
		this.oRowInput = tmp[0];
		this.oColumnInput = tmp[1];
		this.oBorderWidthInput = tmp[2];
		this.oBorderColorInput = tmp[3];
		this.oBGColorInput = tmp[4];
		tmp = cssquery("BUTTON", this.elDropdownLayer);
		this.oButton_AddRow = tmp[0];
		this.oButton_RemoveRow = tmp[1];
		this.oButton_AddColumn = tmp[2];
		this.oButton_RemoveColumn = tmp[3];
		this.oButton_IncBorderWidth = tmp[4];
		this.oButton_DecBorderWidth = tmp[5];
		this.oButton_BorderColorPreview = tmp[6];
		this.oButton_BorderColor = tmp[7];
		this.oButton_BGColorPreview = tmp[8];
		this.oButton_BGColor = tmp[9];
		this.oButton_Insert = tmp[10];
		this.oButton_Cancel = tmp[11];
		this.oSampleTable = cssquery.getSingle("TABLE", this.elDropdownLayer);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.exec("REGISTER_UI_EVENT", [ "table", "click",
				"ST_TOGGLE_TOOLBAR_LAYER" ]);
		this.oApp.registerBrowserEvent(this.oRowInput, "change",
				"ST_SET_ROW_NUM", [ null, 0 ]);
		this.oApp.registerBrowserEvent(this.oColumnInput, "change",
				"ST_SET_COLUMN_NUM", [ null, 0 ]);
		this.oApp.registerBrowserEvent(this.oBorderWidthInput, "change",
				"ST_SET_BORDER_WIDTH", [ null, 0 ]);
		this.oApp.registerBrowserEvent(this.oButton_AddRow, "click",
				"ST_ADD_ROW");
		this.oApp.registerBrowserEvent(this.oButton_RemoveRow, "click",
				"ST_REMOVE_ROW");
		this.oApp.registerBrowserEvent(this.oButton_AddColumn, "click",
				"ST_ADD_COLUMN");
		this.oApp.registerBrowserEvent(this.oButton_RemoveColumn, "click",
				"ST_REMOVE_COLUMN");
		this.oApp.registerBrowserEvent(this.oButton_IncBorderWidth, "click",
				"ST_INC_BORDER_WIDTH");
		this.oApp.registerBrowserEvent(this.oButton_DecBorderWidth, "click",
				"ST_DEC_BORDER_WIDTH");
		this.oApp.registerBrowserEvent(this.oButton_BorderColorPreview,
				"click", "ST_TOGGLE_BORDER_COLOR_LAYER");
		this.oApp.registerBrowserEvent(this.oButton_BGColorPreview, "click",
				"ST_TOGGLE_BGCOLOR_LAYER");
		this.oApp.registerBrowserEvent(this.oButton_BorderColor, "click",
				"ST_TOGGLE_BORDER_COLOR_LAYER");
		this.oApp.registerBrowserEvent(this.oButton_BGColor, "click",
				"ST_TOGGLE_BGCOLOR_LAYER");
		this.oApp.registerBrowserEvent(this.oButton_Insert, "click",
				"ST_INSERT_TABLE");
		this.oApp
				.registerBrowserEvent(this.oButton_Cancel, "click", "ST_CLOSE");
		this.oApp.exec("ST_SET_BORDER_COLOR", [ "#CCCCCC" ]);
		this.oApp.exec("ST_SET_BGCOLOR", [ "#FFFFFF" ]);
	},
	$ON_ST_TOGGLE_TOOLBAR_LAYER : function() {
		this.oApp.exec("RECORD_UNDO_ACTION_FORCED", [ "KEYPRESS" ]);
		this.oSelection = this.oApp.getSelection();
		this.oInsertionPointBookmark = this.oSelection.getXPathBookmark();
		this._showNewTable();
		this.oApp.exec("TOGGLE_TOOLBAR_ACTIVE_LAYER", [ this.elDropdownLayer ]);
	},
	$ON_ST_ADD_ROW : function() {
		this.oApp.exec("ST_SET_ROW_NUM", [ null, 1 ]);
	},
	$ON_ST_REMOVE_ROW : function() {
		this.oApp.exec("ST_SET_ROW_NUM", [ null, -1 ]);
	},
	$ON_ST_ADD_COLUMN : function() {
		this.oApp.exec("ST_SET_COLUMN_NUM", [ null, 1 ]);
	},
	$ON_ST_REMOVE_COLUMN : function() {
		this.oApp.exec("ST_SET_COLUMN_NUM", [ null, -1 ]);
	},
	$ON_ST_SET_ROW_NUM : function(iRows, iRowDiff) {
		iRows = iRows || parseInt(this.oRowInput.value);
		iRowDiff = iRowDiff || 0;
		iRows += iRowDiff;
		if (iRows < this.iMinRows)
			iRows = this.iMinRows;
		if (iRows > this.iMaxRows)
			iRows = this.iMaxRows;
		this.oRowInput.value = iRows;
		this._showNewTable();
	},
	$ON_ST_SET_COLUMN_NUM : function(iColumns, iColumnDiff) {
		iColumns = iColumns || parseInt(this.oColumnInput.value);
		iColumnDiff = iColumnDiff || 0;
		iColumns += iColumnDiff;
		if (iColumns < this.iMinColumns)
			iColumns = this.iMinColumns;
		if (iColumns > this.iMaxColumns)
			iColumns = this.iMaxColumns;
		this.oColumnInput.value = iColumns;
		this._showNewTable();
	},
	$ON_ST_INSERT_TABLE : function() {
		var sTable = this._getTableString();
		this.oSelection.moveToBookmark(this.oInsertionPointBookmark);
		this.oApp.exec("PASTE_HTML", [ sTable, this.oSelection ]);
		this.oApp.exec("ST_CLOSE", []);
	},
	$ON_ST_CLOSE : function() {
		this.oApp.exec("HIDE_ACTIVE_LAYER", []);
	},
	$ON_ST_SET_BORDER_WIDTH : function(iBorderWidth, iBorderWidthDiff) {
		iBorderWidth = iBorderWidth || parseInt(this.oBorderWidthInput.value);
		iBorderWidthDiff = iBorderWidthDiff || 0;
		iBorderWidth += iBorderWidthDiff;
		if (iBorderWidth < this.iMinBorderWidth)
			iBorderWidth = this.iMinBorderWidth;
		if (iBorderWidth > this.iMaxBorderWidth)
			iBorderWidth = this.iMaxBorderWidth;
		this.oBorderWidthInput.value = iBorderWidth;
		this._showNewTable();
	},
	$ON_ST_INC_BORDER_WIDTH : function() {
		this.oApp.exec("ST_SET_BORDER_WIDTH", [ null, 1 ]);
	},
	$ON_ST_DEC_BORDER_WIDTH : function() {
		this.oApp.exec("ST_SET_BORDER_WIDTH", [ null, -1 ]);
	},
	$ON_ST_TOGGLE_BORDER_COLOR_LAYER : function() {
		if (this.welDropdownLayer.hasClass("p1"))
			this.oApp.exec("ST_HIDE_BORDER_COLOR_LAYER", []);
		else
			this.oApp.exec("ST_SHOW_BORDER_COLOR_LAYER", []);
	},
	$ON_ST_SHOW_BORDER_COLOR_LAYER : function() {
		this.welDropdownLayer.addClass("p1");
		this.welDropdownLayer.removeClass("p2");
		this.oApp.exec("SHOW_COLOR_PALETTE", [
				"ST_SET_BORDER_COLOR_FROM_PALETTE", this.elDropdownLayer ]);
	},
	$ON_ST_HIDE_BORDER_COLOR_LAYER : function() {
		this.welDropdownLayer.removeClass("p1");
		this.oApp.exec("HIDE_COLOR_PALETTE", []);
	},
	$ON_ST_TOGGLE_BGCOLOR_LAYER : function() {
		if (this.welDropdownLayer.hasClass("p2"))
			this.oApp.exec("ST_HIDE_BGCOLOR_LAYER", []);
		else
			this.oApp.exec("ST_SHOW_BGCOLOR_LAYER", []);
	},
	$ON_ST_SHOW_BGCOLOR_LAYER : function() {
		this.welDropdownLayer.removeClass("p1");
		this.welDropdownLayer.addClass("p2");
		this.oApp.exec("SHOW_COLOR_PALETTE", [ "ST_SET_BGCOLOR_FROM_PALETTE",
				this.elDropdownLayer ]);
	},
	$ON_ST_HIDE_BGCOLOR_LAYER : function() {
		this.welDropdownLayer.removeClass("p2");
		this.oApp.exec("HIDE_COLOR_PALETTE", []);
	},
	$ON_ST_SET_BORDER_COLOR_FROM_PALETTE : function(sColorCode) {
		this.oApp.exec("ST_SET_BORDER_COLOR", [ sColorCode ]);
		this.oApp.exec("ST_HIDE_BORDER_COLOR_LAYER", []);
	},
	$ON_ST_SET_BORDER_COLOR : function(sColorCode) {
		this.oBorderColorInput.value = sColorCode;
		this.oButton_BorderColorPreview.style.backgroundColor = sColorCode;
		this._showNewTable();
	},
	$ON_ST_SET_BGCOLOR_FROM_PALETTE : function(sColorCode) {
		this.oApp.exec("ST_SET_BGCOLOR", [ sColorCode ]);
		this.oApp.exec("ST_HIDE_BGCOLOR_LAYER", []);
	},
	$ON_ST_SET_BGCOLOR : function(sColorCode) {
		this.oBGColorInput.value = sColorCode;
		this.oButton_BGColorPreview.style.backgroundColor = sColorCode;
		this._showNewTable();
	},
	_showNewTable : function() {
		var oTmp = document.createElement("DIV");
		oTmp.innerHTML = this._getTableString();
		var oNewTable = oTmp.firstChild;
		this.oSampleTable.parentNode.insertBefore(oNewTable, this.oSampleTable);
		this.oSampleTable.parentNode.removeChild(this.oSampleTable);
		this.oSampleTable = oNewTable;
	},
	_getTableString : function() {
		var sBorderColorCode = this.oBorderColorInput.value;
		var sBGColorCode = this.oBGColorInput.value;
		var iBorderWidth = this.oBorderWidthInput.value;
		var sTD = "";
		if ($Agent().navigator().ie) {
			sTD = "<td><p></p></td>";
		} else {
			if ($Agent().navigator().firefox) {
				sTD = "<td><p><br/></p></td>";
			} else {
				sTD = "<td><p>&nbsp;</p></td>";
			}
		}
		var sTable = '<table style="background:' + sBorderColorCode
				+ '" cellspacing="' + iBorderWidth + '">';
		var sRow = '<tr style="background:' + sBGColorCode + '">';
		var iColumns = this.oColumnInput.value;
		for (var i = 0; i < iColumns; i++) {
			sRow += sTD;
		}
		sRow += "</tr>\n";
		var iRows = this.oRowInput.value;
		sTable += "<tbody>";
		for (var i = 0; i < iRows; i++) {
			sTable += sRow;
		}
		sTable += "</tbody>";
		sTable += "</table>";
		return sTable;
	}
});
nhn.husky.SE_EditingModeToggler = $Class({
	name : "SE_EditingModeToggler",
	$init : function(elAppContainer) {
		this._assignHTMLObjects(elAppContainer);
	},
	_assignHTMLObjects : function(elAppContainer) {
		elAppContainer = $(elAppContainer) || document;
		this.elModeToggleButton = cssquery.getSingle(
				"BUTTON.husky_seditor_mode_toggle_button", elAppContainer);
		this.welModeToggleButton = $Element(this.elModeToggleButton);
	},
	$ON_MSG_APP_READY : function() {
		this.oApp.registerBrowserEvent(this.elModeToggleButton, "click",
				"EVENT_TOGGLE_EDITING_MODE", []);
	},
	$ON_EVENT_TOGGLE_EDITING_MODE : function() {
		if (this.oApp.getEditingMode() == "WYSIWYG")
			this.oApp.exec("CHANGE_EDITING_MODE", [ "HTMLSrc" ]);
		else
			this.oApp.exec("CHANGE_EDITING_MODE", [ "WYSIWYG" ]);
	},
	$ON_CHANGE_EDITING_MODE : function(sMode) {
		if (sMode == "HTMLSrc") {
			this.welModeToggleButton.addClass("active");
			this.oApp.exec("DISABLE_ALL_UI", []);
		} else {
			this.welModeToggleButton.removeClass("active");
			this.oApp.exec("ENABLE_ALL_UI", []);
		}
	}
});
var oMessageMap = {
	'SE_EditingAreaManager.onExit' : '%uB0B4%uC6A9%uC774%20%uBCC0%uACBD%uB418%uC5C8%uC2B5%uB2C8%uB2E4.',
	'SE_FontColor.invalidColorCode' : '%uC0C9%uC0C1%20%uCF54%uB4DC%uB97C%20%uC62C%uBC14%uB974%uAC8C%20%uC785%uB825%uD558%uC5EC%20%uC8FC%uC2DC%uAE30%20%uBC14%uB78D%uB2C8%uB2E4.\n\n%uC608%29%20%23000000%2C%20%23FF0000%2C%20%23FFFFFF%2C%20%23ffffff%2C%20ffffff',
	'SE_BGColor.invalidColorCode' : '%uC0C9%uC0C1%20%uCF54%uB4DC%uB97C%20%uC62C%uBC14%uB974%uAC8C%20%uC785%uB825%uD558%uC5EC%20%uC8FC%uC2DC%uAE30%20%uBC14%uB78D%uB2C8%uB2E4.\n\n%uC608%29%20%23000000%2C%20%23FF0000%2C%20%23FFFFFF%2C%20%23ffffff%2C%20ffffff',
	'SE_Hyperlink.invalidURL' : '%uC785%uB825%uD558%uC2E0%20URL%uC774%20%uC62C%uBC14%uB974%uC9C0%20%uC54A%uC2B5%uB2C8%uB2E4.',
	'SE_FindReplace.keywordMissing' : '%uCC3E%uC73C%uC2E4%20%uB2E8%uC5B4%uB97C%20%uC785%uB825%uD574%20%uC8FC%uC138%uC694.',
	'SE_FindReplace.keywordNotFound' : '%uCC3E%uC73C%uC2E4%20%uB2E8%uC5B4%uAC00%20%uC5C6%uC2B5%uB2C8%uB2E4.',
	'SE_FindReplace.replaceAllResultP1' : '%uC77C%uCE58%uD558%uB294%20%uB0B4%uC6A9%uC774%20%uCD1D%20',
	'SE_FindReplace.replaceAllResultP2' : '%uAC74%20%uBC14%uB00C%uC5C8%uC2B5%uB2C8%uB2E4.',
	'SE_FindReplace.notSupportedBrowser' : '%uD604%uC7AC%20%uC0AC%uC6A9%uD558%uACE0%20%uACC4%uC2E0%20%uBE0C%uB77C%uC6B0%uC800%uC5D0%uC11C%uB294%20%uC0AC%uC6A9%uD558%uC2E4%uC218%20%uC5C6%uB294%20%uAE30%uB2A5%uC785%uB2C8%uB2E4.%5Cn%uC774%uC6A9%uC5D0%20%uBD88%uD3B8%uC744%20%uB4DC%uB824%20%uC8C4%uC1A1%uD569%uB2C8%uB2E4.'
};
function createSEditorInIFrame(elIFrame, elIRField) {
	if (!window.$Jindo) {
		parent.document.body.innerHTML = "진도 프레임웍이 필요합니다.<br>\n<a href='http://dev.naver.com/projects/jindo/download'>http://dev.naver.com/projects/jindo/download</a>에서 jindo.min.js를 다운로드 받아 /js 폴더에 복사 해 주세요.";
		return;
	}
	nEditingAreaHeight = elIRField.offsetHeight;
	nEditingAreaWidth = elIRField.style.width;
	elIRField.style.display = "none";
	elIFrame.style.width = nEditingAreaWidth;
	elAppContainer = elIFrame.contentWindow.document.body;
	var oWYSIWYGIFrame = cssquery.getSingle(".input_area IFRAME.input_wysiwyg",
			elAppContainer);
	var oHTMLSrcTextarea = cssquery.getSingle(
			".input_area TEXTAREA.input_syntax", elAppContainer);
	var oIRTextarea = elIRField ? elIRField : cssquery.getSingle(
			".input_area TEXTAREA.blind", elAppContainer);
	var oEditor = new nhn.husky.HuskyCore();
	oEditor.registerPlugin(new nhn.husky.StringConverterManager());
	oEditor.registerPlugin(new nhn.husky.SE_EditingAreaManager("WYSIWYG",
			oIRTextarea, {
				nHeight : nEditingAreaHeight,
				nMinHeight : 205
			}, null, elAppContainer));
	oEditor
			.registerPlugin(new nhn.husky.SE_EditingArea_WYSIWYG(oWYSIWYGIFrame));
	oEditor.registerPlugin(new nhn.husky.SE_EditingArea_HTMLSrc(
			oHTMLSrcTextarea));
	oEditor.registerPlugin(new nhn.husky.Utils());
	oEditor.registerPlugin(new nhn.husky.DialogLayerManager());
	oEditor.registerPlugin(new nhn.husky.ActiveLayerManager());
	oEditor.registerPlugin(new nhn.husky.HuskyRangeManager(oWYSIWYGIFrame));
	oEditor.registerPlugin(new nhn.husky.Hotkey());
	oEditor.registerPlugin(new nhn.husky.SE_WYSIWYGStyler());
	oEditor.registerPlugin(new nhn.husky.SE_WYSIWYGStyleGetter());
	oEditor.registerPlugin(new nhn.husky.SE_Toolbar(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_ExecCommand(oWYSIWYGIFrame));
	oEditor.registerPlugin(new nhn.husky.SE_WYSIWYGEnterKey(oWYSIWYGIFrame));
	oEditor.registerPlugin(new nhn.husky.SE_ColorPalette(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_FontColor(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_BGColor(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_Quote(elAppContainer));
	oEditor
			.registerPlugin(new nhn.husky.SE_FontNameWithSelectUI(
					elAppContainer));
	oEditor
			.registerPlugin(new nhn.husky.SE_FontSizeWithSelectUI(
					elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_LineHeightWithSelectUI(
			elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_UndoRedo());
	oEditor.registerPlugin(new nhn.husky.SE_Table(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_FileUpload(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_Hyperlink(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_EditingModeToggler(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.MessageManager(oMessageMap));
	oEditor.registerPlugin(new nhn.husky.SE_SCharacter(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_FindReplacePlugin(elAppContainer));
	oEditor.registerPlugin(new nhn.husky.SE_OuterIFrameControl(elAppContainer,
			100));
	return oEditor;
}