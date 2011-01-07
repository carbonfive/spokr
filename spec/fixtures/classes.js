ROOT = {
  childClasses: ["Forums"]
};

Forums = {
  autoCreate      : true,
  container       : "forums",
  states          : ["OK"],
  initialState    : "OK",
  read            : [ {fromState: ["OK"], roles:["ANONYMOUS"]} ],
  childClasses    : ["Forum"]
};

Forum = {
  autoCreate      : false,
  states          : ["OK", "STICKY", "INACTIVE", "HIDDEN"],
  initialState    : "OK",
  read            : [ {fromState: ["OK","STICKY", "INACTIVE"], roles:["ANONYMOUS"]} ],
  create          : ["ANONYMOUS"],
  childClasses    : ["Topic"],
  initialPayload  : { children: 0 },
  aggregator      : function(state, newPost, oldPost) {
    if (newPost.postClass.match("/*Topic") == null) return null;

    var visibleStates = {"OK":true, "STICKY":true, "INACTIVE": true};
    var count = 0;
    if (newPost.state in visibleStates)
    {
      if (oldPost == null || !(oldPost.state in visibleStates))
        count++;
    }
    else if (oldPost != null && (oldPost.state in visibleStates))
      count--;

    if ( count == 0 )
      return null;

    state.children += count;
    return state;
  }
};

Topic = {
  states          : ["OK", "INACTIVE", "STICKY", "HIDDEN"],
  initialState    : "OK",
  read            : [ {fromState: ["OK","STICKY", "INACTIVE"], roles:["ANONYMOUS"] } ],
  create          : ["ANONYMOUS"],
  updateState     : [
                      {fromState: ["OK"], roles:["AUTHENTICATED"], toState: ["STICKY"]},
                      {fromState: ["*"], roles:["PORTAL_ADMIN"], toState: ["*"]}
                    ],
  initialPayload  : { children: 0 },
  childClasses    : ["Post"],
  aggregator      : function(state, newPost, oldPost) {
    if (newPost.postClass.match("/*Post") == null) return null;

    var visibleStates = {"OK":true, "INACTIVE": true};
    var count = 0;
    if (newPost.state in visibleStates)
    {
      if (oldPost == null || !(oldPost.state in visibleStates))
        count++;
    }
    else if (oldPost != null && (oldPost.state in visibleStates))
      count--;

    if ( count == 0 )
      return null;

    state.children += count;
    return state;
  }
};

Post = {
  states          : ["OK", "INACTIVE", "HIDDEN"],
  initialState    : "OK",
  read            : [ {fromState: ["OK","INACTIVE"], roles:["ANONYMOUS"]} ],
  create          : ["AUTHENTICATED"],
  update          : ["AUTHOR"],
  updateState     : [ {fromState: ["*"], roles:["PORTAL_ADMIN"], toState: ["*"]} ],
  childClasses    : ["Post"],
  initialPayload  : { children: 0 },
  aggregator      : function(state, newPost, oldPost) {
    if (newPost.postClass.match("/*Post") == null) return null;

    var visibleStates = {"OK":true, "INACTIVE": true};
    var count = 0;
    if (newPost.state in visibleStates)
    {
      if (oldPost == null || !(oldPost.state in visibleStates))
        count++;
    }
    else if (oldPost != null && (oldPost.state in visibleStates))
      count--;

    if ( count == 0 )
      return null;

    state.children += count;
    return state;
  }
};
