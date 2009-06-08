package require tdom

namespace eval ::ims {}
namespace eval ::ims::qti {

  dom createNodeCmd cdataNode   cdata
  dom createNodeCmd textNode    t
  dom createNodeCmd commentNode c
  dom createNodeCmd parserNode  x
  dom createNodeCmd piNode      runtime

  dom createNodeCmd elementNode assessmentItem
  dom createNodeCmd elementNode correctResponse
  dom createNodeCmd elementNode responseDeclaration
  dom createNodeCmd elementNode responseProcessing
  dom createNodeCmd elementNode value
  dom createNodeCmd elementNode outcomeDeclaration
  dom createNodeCmd elementNode defaultValue
  dom createNodeCmd elementNode itemBody
  dom createNodeCmd elementNode choiceInteraction
  dom createNodeCmd elementNode prompt
  dom createNodeCmd elementNode simpleChoice

}


# QUICK AND DIRTY YET

namespace eval ::ims {}
namespace eval ::ims::qti {

    ####################################################
    #
    # IMS QTI Item
    #
    ####################################################

    Class create Item -parameter {
        {identifier ""}
        {title ""}
        {label ""}
        {lang "en-EN"}
        {adaptive false}
        {timeDependent false}
        {toolName "OpenACS IMS QTI Package"}
        {toolVersion "0.1d"}
    }

    Item instproc init {} {
        if {[my identifier] eq ""} {my set identifier [self]}
        if {[my label] eq ""} {my set label [my identifier]}
        if {[my title] eq ""} {my set title [my label]}
    }



    Item ad_instproc render {} {} {
        set xml "<assessmentItem xsi:schemaLocation='http://www.imsglobal.org/xsd/imsqti_v2p0 imsqti_v2p0.xsd' identifier='[my identifier]' title='[my title]' adaptive='[my adaptive]' timeDependent='[my timeDependent]' label='[my label]' lang='[my lang]' toolName='[my toolName]' toolVersion='[my toolVersion]'>
        <responseDeclaration identifier='RESPONSE' cardinality='single' baseType='identifier'>            <correctResponse>            <value>ChoiceA</value>            </correctResponse>            </responseDeclaration></assessmentItem> "
        set document [dom parse $xml ]
        set document [dom createDocumentNode]
        $document appendFromScript {
            ::ims::qti::assessmentItem \
                -xsi:schemaLocation "http://www.imsglobal.org/xsd/imsqti_v2p0 imsqti_v2p0.xsd" \
                -identifier [my identifier] \
                -title [my title] \
                -adaptive [my adaptive] \
                -timeDependent [my timeDependent] \
                -label [my label] \
                -lang [my lang] \
                -toolName [my toolName] \
                -toolVersion [my toolVersion]
        }

        [$document documentElement] appendFromScript {
            my render_responseDeclaration
            my render_outcomeDeclaration
            my render_itemBody
        }

        $document asXML
    }

    Item ad_instproc render_responseDeclaration {} {} {
        ::ims::qti::responseDeclaration
    }

    Item ad_instproc render_outcomeDeclaration {} {} {
        ::ims::qti::outcomeDeclaration
    }

    Item ad_instproc render_itemBody {} {} {
        ::ims::qti::itemBody
    }







}

