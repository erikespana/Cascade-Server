<?php
/**
  Authour: Wing Ming Chan
  Last Modified: Oct 22, 2013
  Comments: Added all methods
 */
class AssetOperationHandlerService
{
    // from the constructor
    private $url;              // string
    private $auth;             // array
    private $soapClient;       // the client
    // from the reply
    private $message;          // string
    private $success;          // string
    private $createdAssetId;   // string
    private $lastRequest;      // xml string
    private $lastResponse;     // xml string
    private $reply;            // xml string
    private $audits;
    private $searchMatches;
    private $listed_messages;  // trio
    
    public function __construct( $url, $auth )
    {
        $this->url            = $url;
        $this->auth           = $auth;
        $this->message        = '';
        $this->success        = '';
        $this->createdAssetId = '';
        $this->lastRequest    = '';
        $this->lastResponse   = '';
        $this->soapClient     = new SoapClient( $this->url, array( 'trace' => 1 ) );
    }
    
    // getters
    public function getAudits()
    {
        return $this->audits;
    }
    
    public function getCreatedAssetId()
    {
        return $this->createdAssetId;
    }
    
    public function getLastRequest()
    {
        return $this->lastRequest;
    }
    
    public function getLastResponse()
    {
        return $this->lastResponse;
    }
    
    public function getListedMessages()
    {
    	return $this->listed_messages;
    }
    
    public function getMessage()
    {
        return $this->message;
    }
    
    public function getReadAccessRightInformation()
    {
        return $this->reply->readAccessRightsReturn->accessRightsInformation;
    }
    
    public function getReadAsset()
    {
        return $this->reply->readReturn->asset;
    }
    
    public function getReadFile()
    {
        return $this->reply->readReturn->asset->file;
    }
    
    public function getReadWorkflow()
    {
        return $this->reply->readWorkflowInformationReturn->workflow;
    }
    
    public function getReply()
    {
        return $this->reply;
    }
    
    public function getSuccess()
    {
        return $this->success;
    }
    
    public function getReadWorkflowSettings()
    {
        return $this->reply->readWorkflowSettingsReturn->workflowSettings;
    }
    
    public function getSearchMatches()
    {
    	return $this->searchMatches;
    }
    
    public function isSuccessful()
    {
        return $this->success == 'true';
    }
    
    public function printLastRequest()
    {
        print_r( $this->lastRequest );
    }
    
    public function printLastResponse()
    {
        print_r( $this->lastResponse );
    }
    
    /**
    * Batch-execution
    * $operations the array of operations
    */
    function batch( $operations )
    {
        $batch_param = new stdClass();
        $batch_param->authentication = $this->auth;
        $batch_param->operation = $operations;
        
        $this->reply = $this->soapClient->batch( $batch_param );
        
        // the returned object is an array
        //$this->success = $this->reply->batchReturn->success;
        //$this->message = $this->reply->batchReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Check in an asset with the given identifier
    * $identifier the identifier of the asset to be checked in
    * $comments the comments to be added
    */
    function checkIn( $identifier, $comments='' )
    {
        $checkin_param = new stdClass();
        $checkin_param->authentication = $this->auth;
        $checkin_param->identifier     = $identifier;
        $checkin_param->comments       = $comments;
        
        $this->reply = $this->soapClient->checkIn( $checkin_param );
        
        $this->success = $this->reply->checkInReturn->success;
        $this->message = $this->reply->checkInReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
        var_dump( $this->success );
    }
    
    /**
    * Check out an asset with the given identifier
    * $identifier the identifier of the asset to be checked out
    */
    function checkOut( $identifier )
    {
        $checkout_param = new stdClass();
        $checkout_param->authentication = $this->auth;
        $checkout_param->identifier     = $identifier;
        
        $this->reply = $this->soapClient->checkOut( $checkout_param );
        
        echo "From method: ";
        echo $this->reply->checkOutReturn->success . "<br />";
        
        
        $this->success = $this->reply->checkOutReturn->success;
        $this->message = $this->reply->checkOutReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Copy the asset with the given identifier
    * $identifier the identifier of the object to be copied
    * $newIdentifier the new identifier of the new object
    * $newName the new name assigned to the new object
    * $doWorkflow whether to do any workflow
    */
    public function copy( $identifier, $newIdentifier, $newName, $doWorkflow ) 
    {
        $copy_params = new stdClass();
        $copy_params->authentication = $this->auth;
        $copy_params->identifier     = $identifier;
        $copy_params->copyParameters->destinationContainerIdentifier = $newIdentifier;
        $copy_params->copyParameters->newName = $newName;
        $copy_params->copyParameters->doWorkflow = $doWorkflow;
        
        $this->reply = $this->soapClient->copy( $copy_params );
        
        $this->success = $this->reply->copyReturn->success;
        $this->message = $this->reply->copyReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Creates the given asset
    * $asset the asset--should be an Asset object
    */
    public function create( $asset ) 
    {
        $create_params = new stdClass();
        $create_params->authentication = $this->auth;
        $create_params->asset = $asset;
        
        $this->reply = $this->soapClient->create( $create_params );
        
        $this->success = $this->reply->createReturn->success;
        $this->message = $this->reply->createReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /*
    * Deletes the asset with the given identifier
    * $identifier the identifier of the object to be deleted
    */
    public function delete( $identifier )
    {
        $delete_params = new stdClass();
        $delete_params->authentication = $this->auth;
        $delete_params->identifier     = $identifier;
        
        $this->reply = $this->soapClient->delete( $delete_params );
        
        $this->success = $this->reply->deleteReturn->success;
        $this->message = $this->reply->deleteReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /*
    * Deletes the asset with the given identifier
    * $identifier the identifier of the object to be deleted
    */
    public function deleteMessage( $identifier )
    {
        $delete_message_params = new stdClass();
        $delete_message_params->authentication = $this->auth;
        $delete_message_params->identifier     = $identifier;
        
        $this->reply = $this->soapClient->deleteMessage( $delete_message_params );
        
        $this->success = $this->reply->deleteMessageReturn->success;
        $this->message = $this->reply->deleteMessageReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    
    /**
    * Edits the given asset
    * $asset the asset to be edited
    */
    public function edit( $asset )
    {
        $edit_params = new stdClass();
        $edit_params->authentication = $this->auth;
        $edit_params->asset = $asset;
        
        $this->reply = $this->soapClient->edit( $edit_params );
        
        $this->success = $this->reply->editReturn->success;
        $this->message = $this->reply->editReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Edits the given accessRightsInformation
    * $accessRightsInformation the accessRightsInformation to be edited
    * $applyToChildren whether to apply the settings to children
    */
    public function editAccessRights( $accessRightsInformation, $applyToChildren )
    {
        $edit_params = new stdClass();
        $edit_params->authentication = $this->auth;
        $edit_params->accessRightsInformation = $accessRightsInformation;
        $edit_params->applyToChildren = $applyToChildren;
        
        $this->reply = $this->soapClient->editAccessRights( $edit_params );
        
        $this->success = $this->reply->editAccessRightsReturn->success;
        $this->message = $this->reply->editAccessRightsReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Edits the given workflowSettings
    * $workflowSettings the workflowSettings to be edited
    * $applyInheritWorkflowsToChildren whether to apply inherited workflows to children
    * $applyRequireWorkflowToChildren whether to apply required workflows to children
    */
    public function editWorkflowSettings( 
    	$workflowSettings, $applyInheritWorkflowsToChildren, $applyRequireWorkflowToChildren )
    {
        $edit_params = new stdClass();
        $edit_params->authentication = $this->auth;
        $edit_params->workflowSettings = $workflowSettings;
        $edit_params->applyInheritWorkflowsToChildren = $applyInheritWorkflowsToChildren;
        $edit_params->applyRequireWorkflowToChildren = $applyRequireWorkflowToChildren;
        
        $this->reply = $this->soapClient->editWorkflowSettings( $edit_params );
        
        $this->success = $this->reply->editWorkflowSettingsReturn->success;
        $this->message = $this->reply->editWorkflowSettingsReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }   
    
    /**
    * Lists all messages
    */
    public function listMessages()
    {
        $list_messages_params = new stdClass();
        $list_messages_params->authentication = $this->auth;
        
        $this->reply = $this->soapClient->listMessages( $list_messages_params );
        
        $this->success = $this->reply->listMessagesReturn->success;
        $this->message = $this->reply->listMessagesReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
        
        if( $this->isSuccessful() )
        {
        	$this->listed_messages = $this->reply->listMessagesReturn->messages;
        }
    }
    
    /**
    * Lists all sites
    */
    public function listSites()
    {
        $list_sites_params = new stdClass();
        $list_sites_params->authentication = $this->auth;
        
        $this->reply = $this->soapClient->listSites( $list_sites_params );
        
        $this->success = $this->reply->listSitesReturn->success;
        $this->message = $this->reply->listSitesReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Lists all subscribers
    * $identifier the identifier of the asset
    */
    public function listSubscribers( $identifier )
    {
        $list_subscribers_params = new stdClass();
        $list_subscribers_params->authentication = $this->auth;
        $list_subscribers_params->identifier     = $identifier;
        
        $this->reply = $this->soapClient->listSubscribers( $list_subscribers_params );
        
        $this->success = $this->reply->listSubscribersReturn->success;
        $this->message = $this->reply->listSubscribersReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Lists all subscribers
    * $identifier the identifier of the asset
    */
    public function markMessage( $identifier, $markType )
    {
        $mark_message_params = new stdClass();
        $mark_message_params->authentication = $this->auth;
        $mark_message_params->identifier     = $identifier;
        $mark_message_params->markType       = $markType;
        
        $this->reply = $this->soapClient->markMessage( $mark_message_params );
        
        $this->success = $this->reply->markMessageReturn->success;
        $this->message = $this->reply->markMessageReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Move the asset with the given identifier
    * $identifier the identifier of the object to be moved
    * $newIdentifier the new container identifier
    * $newName the new name assigned to the object moved
    # $doWorkflow whether to do workflow
    */
    function move( $identifier, $newIdentifier, $newName, $doWorkflow ) 
    {
        $move_params = new stdClass();
        $move_params->authentication = $this->auth;
        $move_params->identifier     = $identifier;
        $move_params->moveParameters->destinationContainerIdentifier = $newIdentifier;
        $move_params->moveParameters->newName = $newName;
        $move_params->moveParameters->doWorkflow = $doWorkflow;
        
        $this->reply = $this->soapClient->move( $move_params );
        
        $this->success = $this->reply->moveReturn->success;
        $this->message = $this->reply->moveReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Performs the workflow transition
    * $workflowId the workflow id
    * $actionIdentifier the identifier of the action
    * $transitionComment the comments
    */
    public function performWorkflowTransition( 
    	$workflowId, $actionIdentifier, $transitionComment='' )
    {
        $workflowTransitionInformation = new stdClass();
        $workflowTransitionInformation->workflowId        = $workflowId;
        $workflowTransitionInformation->actionIdentifier  = $actionIdentifier;
        $workflowTransitionInformation->transitionComment = $transitionComment;
        
        $transition_params = new stdClass();
        $transition_params->authentication                = $this->auth;
        $transition_params->workflowTransitionInformation = $workflowTransitionInformation;
        
        $this->reply = $this->soapClient->performWorkflowTransition( $transition_params );
        
        $this->success = $this->reply->performWorkflowTransitionReturn->success;
        $this->message = $this->reply->performWorkflowTransitionReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Publishes the asset with the given identifier
    * $identifier the identifier of the object to be published
    * $destination the destination(s) to where to be published
    */
    public function publish( $identifier, $destination = NULL ) 
    {
        $publish_param = new stdClass();
        $publish_info  = new stdClass();
        $publish_param->authentication = $this->auth;
        $publish_info->identifier      = $identifier;
        $publish_info->unpublish       = false;
        $publish_param->publishInformation = $publish_info;
        
        if( $destination != NULL )
        {
            if( is_array( $destination ) )
                $publish_param->destinations = $destination;
            else
                $publish_param->destinations = array( $destination );
        }
        
        $this->reply = $this->soapClient->publish( $publish_param );
        
        $this->success = $this->reply->publishReturn->success;
        $this->message = $this->reply->publishReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Reads the asset with the given identifier
    * $identifier the identifier of the object to be read
    */
    public function read( $identifier ) 
    {
        $read_param = new stdClass();
        $read_param->authentication = $this->auth;
        $read_param->identifier     = $identifier;
        
        $this->reply = $this->soapClient->read( $read_param );
        
        $this->success = $this->reply->readReturn->success;
        $this->message = $this->reply->readReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Reads the access rights of the asset with the given identifier
    * $identifier the identifier of the object to be read
    */
    public function readAccessRights( $identifier ) 
    {
        $read_param = new stdClass();
        $read_param->authentication = $this->auth;
        $read_param->identifier     = $identifier;
        
        $this->reply = $this->soapClient->readAccessRights( $read_param );
        
        $this->success = $this->reply->readAccessRightsReturn->success;
        $this->message = $this->reply->readAccessRightsReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Reads the audits of the asset with the given parameters
    * $params the parameters
    */
    public function readAudits( $params ) 
    {
        $read_audits_param = new stdClass();
        $read_audits_param->authentication  = $this->auth;
        $read_audits_param->auditParameters = $params;
        
        $this->reply = $this->soapClient->readAudits( $read_audits_param );
        
        $this->success = $this->reply->readAuditsReturn->success;
        $this->message = $this->reply->readAuditsReturn->message;
        $this->audits  = $this->reply->readAuditsReturn->audits;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Reads the workflow settings associated with the given identifier
    * $identifier the identifier of the object to be read
    */
    public function readWorkflowInformation( $identifier ) 
    {
        $read_param = new stdClass();
        $read_param->authentication = $this->auth;
        $read_param->identifier     = $identifier;
        
        $this->reply = $this->soapClient->readWorkflowInformation( $read_param );
        
        $this->success = $this->reply->readWorkflowInformationReturn->success;
        $this->message = $this->reply->readWorkflowInformationReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }    
    
    /**
    * Reads the workflow settings associated with the given identifier
    * $identifier the identifier of the object to be read
    */
    public function readWorkflowSettings( $identifier ) 
    {
        $read_param = new stdClass();
        $read_param->authentication = $this->auth;
        $read_param->identifier     = $identifier;
        
        $this->reply = $this->soapClient->readWorkflowSettings( $read_param );
        
        $this->success = $this->reply->readWorkflowSettingsReturn->success;
        $this->message = $this->reply->readWorkflowSettingsReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /**
    * Search
    * $message the message to be sent
    */
    public function search( $searchInfo ) 
    {
        $search_info_param = new stdClass();
        $search_info_param->authentication    = $this->auth;
        $search_info_param->searchInformation = $searchInfo;
        
        $this->reply = $this->soapClient->search( $search_info_param );
        
        $this->success = $this->reply->searchReturn->success;
        $this->message = $this->reply->searchReturn->message;
        $this->searchMatches = $this->reply->searchReturn->matches;
        $this->lastRequest   = $this->soapClient->__getLastRequest();
        $this->lastResponse  = $this->soapClient->__getLastResponse();
    }        
    
    /**
    * Send a message
    * $message the message to be sent
    */
    public function sendMessage( $message ) 
    {
        $send_message_param = new stdClass();
        $send_message_param->authentication = $this->auth;
        $send_message_param->message        = $message;
        
        $this->reply = $this->soapClient->sendMessage( $send_message_param );
        
        $this->success = $this->reply->sendMessageReturn->success;
        $this->message = $this->reply->sendMessageReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }    
    
    /**
    * Copy the site with the given identifier
    * $authentication the authentication--should be an Authentication object
    * $original_id the identifier--should be a string
    */
    function siteCopy( $original_id, $original_name, $new_name ) 
    {
        $site_copy_params = new stdClass();
        $site_copy_params->authentication = $this->auth;
        $site_copy_params->originalSiteId = $original_id;
        $site_copy_params->originalSiteName = $original_name;
        $site_copy_params->newSiteName = $new_name;

        $this->reply = $this->soapClient->siteCopy( $site_copy_params );
        
        $this->success = $this->reply->siteCopyReturn->success;
        $this->message = $this->reply->siteCopyReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    /**
    * Unpublishes the asset with the given identifier
    * $identifier the identifier of the object to be unpublished
    */
    public function unpublish( $identifier ) 
    {
        $publish_param = new stdClass();
        $publish_info  = new stdClass();
        $publish_param->authentication = $this->auth;
        $publish_info->identifier      = $identifier;
        $publish_info->unpublish       = true;
        $publish_param->publishInformation = $publish_info;
        
        if( $destination != NULL )
        {
            if( is_array( $destination ) )
                $publish_param->destinations = $destination;
            else
                $publish_param->destinations = array( $destination );
        }
        
        $this->reply = $this->soapClient->publish( $publish_param );
        
        $this->success = $this->reply->publishReturn->success;
        $this->message = $this->reply->publishReturn->message;
        $this->lastRequest  = $this->soapClient->__getLastRequest();
        $this->lastResponse = $this->soapClient->__getLastResponse();
    }
    
    /* search, readWorkflowSettings, editWorkflowSettings, listSubscribers,
    listMessages, markMessage, deleteMessage, sendMessage, checkOut, checkIn, 
    readAudits, readWorkflowInformation, performWorkflowTransition, */
    
    public function createIdWithIdType( $id, $type )
    {
        $identifier       = new stdClass();
        $identifier->id   = $id;
        $identifier->type = $type;
        return $identifier;
    }

    public function createIdWithPathSiteNameType( $path, $siteName, $type )
    {
        $id                 = new stdClass();
        $id->path->path     = $path;
        $id->path->siteName = $siteName;
        $id->type           = $type;
        return $id;
    }

    public function createFileWithParentIdSiteNameNameData( $parentFolderId, $siteName, $name, $data )
    {
        $file = new stdClass();
        $file->parentFolderId = $parentFolderId;
        $file->siteName       = $siteName;
        $file->name           = $name;
        $file->data           = $data;
        return $file;
    }
}
?>