var Spoke = function(params) {
  var spoke = {}, url = params.url || '/spoke', authToken = params.authToken, lastAuthorized = (authToken ? new Date() : new Date(0));
  
  function beforeSend(xhr) {
    xhr.setRequestHeader('Accept', 'application/json');
    if ( authToken )
      xhr.setRequestHeader('Authorization-Spoke', authToken);
  }

  function mapkey(prefix, key) {
    if ( /^\w+$/.exec(key) )
      return prefix ? prefix + '.' + key : key;
    return prefix + '[' + key + ']';
  }

  function parameterize( o, prefix, parameters ) {
    prefix = prefix || ''; parameters = parameters || [];

    if ( jQuery.isArray(o) )
      jQuery.each(o, function(i,e) { parameterize( e, prefix+'['+i+']', parameters) });
    else if ( jQuery.isPlainObject(o) )
      jQuery.each(o, function(i,e) { parameterize( e, mapkey(prefix,i), parameters) });
    else
      parameters.push( encodeURIComponent(prefix) + "=" + encodeURIComponent(o) );

    return parameters;
  }


  spoke.createPost = function(path, post, success, failure) {
    jQuery.ajax({
      url        : url + '/api/posts/' + path,
      beforeSend : beforeSend,
      type       : 'POST',
      data       : parameterize(post).join('&'),
      dataType   : 'json',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  spoke.updatePost = function(path, post, success, failure) {
    jQuery.ajax({
      url        : url + '/api/posts/' + path + '/update',
      beforeSend : beforeSend,
      type       : 'POST',
      data       : parameterize(post).join('&'),
      dataType   : 'json',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  spoke.updateState = function(path, state, success, failure ) {
    jQuery.ajax({
      url        : url + '/api/state/' + path,
      beforeSend : beforeSend,
      type       : 'POST',
      data       : 'state='+encodeURIComponent(state),
      dataType   : 'json',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  function makeQuery(type, path, query, success, failure) {
    if ( query )
      path += '?' + parameterize(query).join('&');
    jQuery.ajax({
      url        : url + '/api/' + type + '/' + path,
      beforeSend : beforeSend,
      dataType   : 'json',
      type       : 'GET',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  }

  spoke.findChildPosts = function(path, query, success, failure) {
    makeQuery('in',path,query,success,failure);
  };

  spoke.findPosts = function(path, query, success, failure) {
    makeQuery('find',path,query,success,failure);
  };

  spoke.load = function(key, query, success, failure) {
    makeQuery('posts',key,query,success,failure);
  };

  spoke.findTags = function( key, success, failure ) {
    jQuery.ajax({
      url        : url + '/api/tags/' + key,
      beforeSend : beforeSend,
      dataType   : 'json',
      type       : 'GET',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  spoke.addTags = function( path, tags, success, failure ) {
    var content = jQuery.map(tags, function(t) { return 'tag='+encodeURIComponent(t); }).join('&');
    jQuery.ajax({
      url        : url + '/api/tags/' + path,
      beforeSend : beforeSend,
      type       : 'POST',
      data       : content,
      dataType   : 'json',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  spoke.findTagCounts = function( path, query, success, failure ) {
    if ( query )
      path += '?' + parameterize(post).join('&');
    jQuery.ajax({
      url        : url + '/api/tag-count/' + path,
      beforeSend : beforeSend,
      dataType   : 'json',
      type       : 'GET',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  spoke.findInteractions = function(query, success, failure ) {
    makeQuery('user-interactions', '', query, success, failure);
  };

  spoke.updateInteraction = function(postKey, type, value, success, failure ) {
    jQuery.ajax({
      url        : url + '/api/interaction/' + postKey,
      beforeSend : beforeSend,
      type       : 'POST',
      data       : 'type=' + encodeURIComponent(type) + (value ? '&value=' + encodeURIComponent(value) : ''),
      dataType   : 'json',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  spoke.deleteInteraction = function(postKey, type, success, failure ) {
    jQuery.ajax({
      url        : url + '/api/unset-interaction/' + postKey,
      beforeSend : beforeSend,
      type       : 'POST',
      data       : 'type=' + encodeURIComponent(type),
      dataType   : 'json',
      success    : function(data, status, request) { if (success) success(data, status, request); },
      error      : function(request, status, error) { if (failure) failure(request, status, error); }
    });
  };

  // reauthorize if the current authorization is more than a minute old.
  var callIndex = 0, authorizing = false;
  function authorize() {
    if ( authorizing )
      return;
    if (( authToken == null ) || ( new Date().getTime() - lastAuthorized.getTime() > 60000 )) {
      authorizing = true;
      authToken = null;
      jQuery.getJSON('/member/spokeAuthorization?ci='+(callIndex++), function(at) {
        authToken = at || "ERROR";
        lastAuthorized=new Date();
        authorizing = false;
      }, function(xhr) {
        authToken = "ERROR";
        lastAuthorized=new Date();
        authorizing = false;
      });
    }
  }
  function delayUntilAuthorized(f) {
    var delayed = function() {
      var self = this, args = arguments;

      authorize();
      if ( authToken != null )
        f.apply(self,args);
      else
        setTimeout( function() { delayed.apply(self,args); }, 100);
    };
    return delayed;
  }

  for ( var k in spoke )
    spoke[k] = delayUntilAuthorized(spoke[k]);


  return spoke;
};