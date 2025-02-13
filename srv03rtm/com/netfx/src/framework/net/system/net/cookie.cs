//------------------------------------------------------------------------------
// <copyright file="cookie.cs" company="Microsoft">
//     Copyright (c) Microsoft Corporation.  All rights reserved.
// </copyright>
//------------------------------------------------------------------------------

namespace System.Net {
    using System.Collections;
    using System.Globalization;
    
    internal enum CookieVariant {
        Unknown,
        Plain,
        Rfc2109,
        Rfc2965,
        Default = Rfc2109
    }

    //
    // Cookie class
    //
    //  Adheres to RFC 2965
    //
    //  Currently, only client-side cookies. The cookie classes know how to
    //  parse a set-cookie format string, but not a cookie format string
    //  (e.g. "Cookie: $Version=1; name=value; $Path=/foo; $Secure")
    //

    /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie"]/*' />
    /// <devdoc>
    ///    <para>[To be supplied.]</para>
    /// </devdoc>
    [Serializable]
    public sealed class Cookie {

        internal const int    MaxSupportedVersion = 1;
        internal const string CommentAttributeName = "Comment";
        internal const string CommentUrlAttributeName = "CommentURL";
        internal const string DiscardAttributeName = "Discard";
        internal const string DomainAttributeName = "Domain";
        internal const string ExpiresAttributeName = "Expires";
        internal const string MaxAgeAttributeName = "Max-Age";
        internal const string PathAttributeName = "Path";
        internal const string PortAttributeName = "Port";
        internal const string SecureAttributeName = "Secure";
        internal const string VersionAttributeName = "Version";

        internal const string SeparatorLiteral = "; ";
        internal const string EqualsLiteral = "=";
        internal const string SpecialAttributeLiteral = "$";
        
        internal static readonly char[] PortSplitDelimiters =  new char[] {' ', ',', '\"'};
        internal static readonly char[] Reserved2Name =  new char[] {' ', '\t', '\r', '\n', '=', ';', ',' };
        internal static readonly char[] Reserved2Value =  new char[] {';', ',' };
        private  static Comparer staticComparer = new Comparer();

    // fields

        string  m_comment = string.Empty;
        Uri     m_commentUri = null;
        CookieVariant m_cookieVariant = CookieVariant.Plain;
        bool    m_discard = false;
        string  m_domain = string.Empty;
        bool    m_domain_implicit = true;
        DateTime m_expires = DateTime.MinValue;
        string  m_name = string.Empty;
        string  m_path = string.Empty;
        bool    m_path_implicit = true;
        string  m_port = string.Empty;
        bool    m_port_implicit = true;
        int[]   m_port_list = null;
        bool    m_secure = false;
        DateTime m_timeStamp = DateTime.Now;
        string  m_value = string.Empty;
        int     m_version = 0;
        
        string  m_domainKey = string.Empty;
        internal bool IsQuotedVersion = false;
        internal bool IsQuotedDomain = false;


    // constructors

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Cookie"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public Cookie() {
        }


        //public Cookie(string cookie) {
        //    if ((cookie == null) || (cookie == String.Empty)) {
        //        throw new ArgumentException("cookie");
        //    }
        //    Parse(cookie.Trim());
        //    Validate();
        //}

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Cookie1"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public Cookie(string name, string value) {
            Name = name;
            m_value = value;
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Cookie2"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public Cookie(string name, string value, string path)
            : this(name, value) {
            Path = path;
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Cookie3"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public Cookie(string name, string value, string path, string domain)
            : this(name, value, path) {
            Domain = domain;
        }

    // properties

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Comment"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public string Comment {
            get {
                return m_comment;
            }
            set {
                if (value == null) {
                    value = string.Empty;
                }
                m_comment = value;
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.CommentUri"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public Uri CommentUri {
            get {
                return m_commentUri;
            }
            set {
                m_commentUri = value;
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Discard"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public bool Discard {
            get {
                return m_discard;
            }
            set {
                m_discard = value;
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Domain"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public string Domain {
            get {
                return m_domain;
            }
            set {
                m_domain = (value == null? String.Empty : value);
                m_domain_implicit = false;
                m_domainKey = string.Empty; //this will get it value when adding into the Container.
            }
        }

        private string _Domain {
            get {
                return (Plain || m_domain_implicit || (m_domain.Length == 0))
                    ? string.Empty
                    : (SpecialAttributeLiteral
                       + DomainAttributeName
                       + EqualsLiteral + (IsQuotedDomain? "\"": string.Empty)
                       + m_domain + (IsQuotedDomain? "\"": string.Empty)
                       );
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Expired"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public bool Expired {
            get {
                return (m_expires <= DateTime.Now) && (m_expires != DateTime.MinValue);
            }
            set {
                if (value == true) {
                    m_expires = DateTime.Now;
                }
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Expires"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public DateTime Expires {
            get {
                return m_expires;
            }
            set {
                m_expires = value;
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Name"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public string Name {
            get {
                return m_name;
            }
            set {
                if (value == null || value == string.Empty || !InternalSetName(value)) {
                    throw new CookieException(SR.GetString(SR.net_cookie_attribute, "Name", value == null? "<null>": value));
                }
            }
        }

        internal bool InternalSetName(string value) {
            if (value == null || value == string.Empty || value[0] == '$' || value.IndexOfAny(Reserved2Name) != -1) {
                m_name = string.Empty;
                return false;
            }
            m_name = value;
            return true;
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Path"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public string Path {
            get {
                return m_path;
            }
            set {
                m_path = (value == null? String.Empty : value);
                m_path_implicit = false;
            }
        }

        private string _Path {
            get {
                return (Plain || m_path_implicit || (m_path.Length == 0))
                    ? string.Empty
                    : (SpecialAttributeLiteral
                       + PathAttributeName
                       + EqualsLiteral
                       + m_path
                       );
            }
        }

        internal bool Plain {
            get {
                return Variant == CookieVariant.Plain;
            }
        }


        //
        // According to spec we must assume default values for attributes but still 
        // keep in mind that we must not include them into the requests.
        // We also check the validiy of all attributes based on the version and variant (read RFC)
        //
        // To work properly this function must be called after cookie construction with
        // default (response) URI AND set_default == true
        //
        // Afterwards, the function can be called many times with other URIs and 
        // set_default == false to check whether this cookie matches given uri
        //

        internal bool VerifySetDefaults(CookieVariant variant, Uri uri, bool isLocalDomain, string localDomain, bool set_default, bool isThrow) {
           
            string host = uri.Host;
            int    port = uri.Port;
            string path = uri.AbsolutePath;
            bool   valid= true;

            if (set_default) {
                // Set Variant. If version is zero => reset cookie to Version0 style
                if (Version == 0) {
                    variant = CookieVariant.Plain;
                }
                else if (Version == 1 && variant == CookieVariant.Unknown) {
                     //since we don't expose Variant to an app, set it to Default
                     variant = CookieVariant.Default;
                }
                m_cookieVariant = variant;
            }

            //Check the name
            if (m_name == null || m_name.Length == 0 || m_name[0] == '$' || m_name.IndexOfAny(Reserved2Name) != -1) {
                if (isThrow) {
                    throw new CookieException(SR.GetString(SR.net_cookie_attribute, "Name", m_name == null? "<null>": m_name));
                }
                return false;
            }

            //Check the value
            if (m_value == null || 
                (!(m_value.Length > 2 && m_value[0] == '\"' && m_value[m_value.Length-1] == '\"') && m_value.IndexOfAny(Reserved2Value) != -1)) {
                if (isThrow) {
                    throw new CookieException(SR.GetString(SR.net_cookie_attribute, "Value", m_value == null? "<null>": m_value));
                }
                return false;
            }

            //Check Comment syntax
            if (Comment != null && !(Comment.Length > 2 && Comment[0] == '\"' && Comment[Comment.Length-1] == '\"') 
                && (Comment.IndexOfAny(Reserved2Value) != -1)) {
                if (isThrow) 
                   throw new CookieException(SR.GetString(SR.net_cookie_attribute, CommentAttributeName, Comment));
                return false;
            }

            //Check Path syntax
            if (Path != null  && !(Path.Length > 2 && Path[0] == '\"' && Path[Path.Length-1] == '\"') 
                && (Path.IndexOfAny(Reserved2Value) != -1)) {
                if (isThrow) {
                    throw new CookieException(SR.GetString(SR.net_cookie_attribute, PathAttributeName, Path));
                }
                return false;
            }

            //Check/set domain
            // if domain is implicit => assume a) uri is valid, b) just set domain to uri hostname
            if (set_default && m_domain_implicit == true) {
                m_domain = host;
            }
            else {
                if (!m_domain_implicit) {
                    // Forwarding note: If Uri.Host is of IP address form then the only supported case
                    // is for IMPLICIT domain property of a cookie.
                    // The below code (explicit cookie.Domain value) will try to parse Uri.Host IP string   
                    // as a fqdn and reject the cookie
                    
                    //aliasing since we might need the KeyValue (but not the original one)
                    string domain = m_domain;

                    //Syntax check for Domain charset plus empty string
                    if (!DomainCharsTest(domain)) {
                        if (isThrow) {
                            throw new CookieException(SR.GetString(SR.net_cookie_attribute, DomainAttributeName, domain == null? "<null>": domain));
                        }
                        return false;
                    }

                    //domain must start with '.' if set explicitly
                    if(domain[0] != '.' ) {
                        if (!(variant == CookieVariant.Rfc2965 || variant == CookieVariant.Plain)) {
                            if (isThrow) {
                                throw new CookieException(SR.GetString(SR.net_cookie_attribute, DomainAttributeName, m_domain));
                            }
                            return false;
                        }
                        domain = '.' + domain;
                    }

                    int  host_dot = host.IndexOf('.');
                    bool   is_local = false;

                    // First quick check is for pushing a cookie into the local domain
                    if (isLocalDomain && (string.Compare(localDomain, domain, true, CultureInfo.InvariantCulture) == 0)) {
                        valid = true;
                    }
                    else if (domain.Length < 4 || (!(is_local = (string.Compare(domain, ".local", true, CultureInfo.InvariantCulture)) == 0) && domain.IndexOf('.', 1, domain.Length-2) == -1)) {
                        // explicit domains must contain 'inside' dots or be ".local"
                        valid = false;
                    }
                    else if (is_local && isLocalDomain) {
                        // valid ".local" found for the local domain Uri
                        valid = true;
                    }
                    else if (is_local && !isLocalDomain) {
                        // ".local" cannot happen on non-local domain
                        valid = false;
                    }
                    else if (variant == CookieVariant.Plain) {
                        // We distiguish between Version0 cookie and other versions on domain issue
                        // According to Version0 spec a domain must be just a substring of the hostname
                        if (host.Length <= domain.Length ||
                            string.Compare(host, host.Length-domain.Length, domain, 0, domain.Length, true, CultureInfo.InvariantCulture) != 0) {
                            valid = false;
                        }
                    }
                    else if ( !is_local && 
                             (host_dot == -1 || 
                             domain.Length != host.Length-host_dot || 
                             string.Compare(host, host_dot, domain, 0, domain.Length, true, CultureInfo.InvariantCulture) != 0)) {
                        //starting the first dot, the host must match the domain
                        valid = false;
                    }

                    if (valid) {
                        if(is_local) {
                            m_domainKey = localDomain.ToLower(CultureInfo.InvariantCulture);
                        }
                        else {
                            m_domainKey = domain.ToLower(CultureInfo.InvariantCulture);
                        }
                    }
                    
                }
                else {
                    // for implicitly set domain AND at the set_default==false time 
                    // we simply got to match uri.Host against m_domain
                    if (string.Compare(host, m_domain, true, CultureInfo.InvariantCulture) != 0) {
                        valid = false;
                    }

                }
                if(!valid) {
                    if (isThrow) {
                        throw new CookieException(SR.GetString(SR.net_cookie_attribute, DomainAttributeName, m_domain));
                    }
                    return false;
                }
            }


            //Check/Set Path

            if (set_default && m_path_implicit == true) {
                //assuming that uri path is always valid and contains at least one '/'
                switch (m_cookieVariant) {
                case CookieVariant.Plain:                   
                                        m_path = path;
                                        break;
                case CookieVariant.Rfc2109:                   
                                        m_path = path.Substring(0, path.LastIndexOf('/')); //may be empty
                                        break;

                case CookieVariant.Rfc2965:
                default:                //hope future versions will have same 'Path' semantic?
                                        m_path = path.Substring(0, path.LastIndexOf('/')+1);
                                        break;

                }
            }
            else {
                //check current path (implicit/explicit) against given uri
                if (!path.StartsWith(CookieParser.CheckQuoted(m_path))) {
                    if (isThrow) {
                        throw new CookieException(SR.GetString(SR.net_cookie_attribute, PathAttributeName, m_path));
                    }
                    return false;
                }
            }
            
            // set the default port if Port attribute was present but had no value
            if (set_default && (m_port_implicit == false && m_port.Length == 0)) {
                m_port_list = new int[1] {port};
            }

            if(m_port_implicit == false) {
                // Port must match agaist the one from the uri
                valid = false;
                foreach (int p in m_port_list) {
                    if (p == port) {
                        valid = true;
                        break;
                    }
                }
                if (!valid) {
                    if (isThrow) {
                        throw new CookieException(SR.GetString(SR.net_cookie_attribute, PortAttributeName, m_port));
                    }
                    return false;
                }
            }
            return true;
        }

        //Very primitive test to make sure that the name does not have illegal characters
        // As pe� RFC 952 (relaxed on first char could be a digit and string can have '_')
        private static bool DomainCharsTest(string name) {
            if (name == null || name.Length == 0) {
                return false;
            }
            for(int i=0; i < name.Length; ++i) {
                char ch = name[i];
                if (!(
                      (ch >= '0' && ch <= '9') ||
                      (ch == '.' || ch == '-') ||
                      (ch >= 'a' && ch <= 'z') ||
                      (ch >= 'A' && ch <= 'Z') ||
                      (ch == '_')
                    ))
                    return false;
            }
            return true;
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Port"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public string Port {
            get {
                return m_port;
            }
            set {
                m_port_implicit = false;
                if ((value == null || value.Length == 0)) {
                    //"Port" is present but has no value.
                    m_port = string.Empty;
                }
                else {
                    m_port = value;
                    // Parse port list
                    if (value[0] != '\"' || value[value.Length-1] != '\"') {
                        throw new CookieException(SR.GetString(SR.net_cookie_attribute, PortAttributeName, m_port));
                    }
                    string[] ports = value.Split(PortSplitDelimiters);
                    m_port_list = new int[ports.Length];
                    for (int i = 0; i < ports.Length; ++i) {
                        m_port_list[i] = -1;        
                        if(ports[i].Length == 0) {
                            //ignore spaces this way, and leave port=-1 in the slot
                            continue;
                        }
                        try {
                            m_port_list[i] = Int32.Parse(ports[i]);
                        }
                        catch (Exception e) {
                            throw new CookieException(SR.GetString(SR.net_cookie_attribute, PortAttributeName, m_port),e);
                        }
                    }
                }
            }
        }


        internal int[] PortList {
            get {
                //It must be null if Port Attribute was ommitted in the response
                return m_port_list;
            }
        }

        private string _Port {
            get {
                return m_port_implicit ? string.Empty :
                      (SpecialAttributeLiteral
                       + PortAttributeName
                       + ((m_port.Length == 0) ? string.Empty : (EqualsLiteral + m_port))
                       );
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Secure"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public bool Secure {
            get {
                return m_secure;
            }
            set {
                m_secure = value;
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.TimeStamp"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public DateTime TimeStamp {
            get {
                return m_timeStamp;
            }
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Value"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public string Value {
            get {
                return m_value;
            }
            set {
                m_value = (value == null? String.Empty : value);
            }
        }

        internal CookieVariant Variant {
            get {
                return m_cookieVariant;
            }
        }

        // m_domainKey member is set internally in VerifySetDefaults()
        // If it is not set then verification function was not called
        // and this shoul dnever happen
        internal string DomainKey {
            get {
                return m_domain_implicit ? Domain : m_domainKey;
            }
        }


        //public Version Version {
        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Version"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public int Version {
            get {
                return m_version;
            }
            set {
                m_version = value;
            }
        }

        private string _Version {
            get {
                  return (Version == 0) ? string.Empty :
                                         ( SpecialAttributeLiteral
                                         + VersionAttributeName
                                         + EqualsLiteral + (IsQuotedVersion? "\"": string.Empty) 
                                         + m_version.ToString() + (IsQuotedVersion? "\"": string.Empty));
            }
        }

    // methods


        internal static IComparer GetComparer() {
            //the class don't have any members, it's safe reuse the instance
            return staticComparer;
        }


        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Equals"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public override bool Equals(object comparand) {
            if (!(comparand is Cookie)) {
                return false;
            }

            Cookie other = (Cookie)comparand;

            return (string.Compare(Name, other.Name, true, CultureInfo.InvariantCulture) == 0)
                    && (string.Compare(Value, other.Value, false, CultureInfo.InvariantCulture) == 0)
                    && (string.Compare(Path, other.Path, false, CultureInfo.InvariantCulture) == 0)
                    && (string.Compare(Domain, other.Domain, true, CultureInfo.InvariantCulture) == 0)
                    && (Version == other.Version)
                    ;
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.GetHashCode"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public override int GetHashCode() {
            //
            //string hashString = Name + "=" + Value + ";" + Path + "; " + Domain + "; " + Version;
            //int hash = 0;
            //
            //foreach (char ch in hashString) {
            //    hash = unchecked(hash << 1 ^ (int)ch);
            //}
            //return hash;
            return (Name + "=" + Value + ";" + Path + "; " + Domain + "; " + Version).GetHashCode();
        }

        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.ToString"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public override string ToString() {

            string domain = _Domain;
            string path = _Path;
            string port = _Port;
            string version = _Version;

            string result = 
                    ((version.Length == 0)? string.Empty : (version + SeparatorLiteral))
                    + Name + EqualsLiteral + Value
                    + ((path.Length == 0)   ? string.Empty : (SeparatorLiteral + path))
                    + ((domain.Length == 0) ? string.Empty : (SeparatorLiteral + domain))
                    + ((port.Length == 0)   ? string.Empty : (SeparatorLiteral + port))
                    ;
            if (result == "=") {
                return string.Empty;
            }
            return result;
        }

        //private void Validate() {
        //    if ((m_name == String.Empty) && (m_value == String.Empty)) {
        //        throw new CookieException();
        //    }
        //    if ((m_name != String.Empty) && (m_name[0] == '$')) {
        //        throw new CookieException();
        //    }
        //}

#if DEBUG
        /// <include file='doc\cookie.uex' path='docs/doc[@for="Cookie.Dump"]/*' />
        /// <devdoc>
        ///    <para>[To be supplied.]</para>
        /// </devdoc>
        public void Dump() {
            Console.WriteLine("Cookie: " + ToString() + "->\n"
                            + "\tComment    = " + Comment + "\n"
                            + "\tCommentUri = " + CommentUri + "\n"
                            + "\tDiscard    = " + Discard + "\n"
                            + "\tDomain     = " + Domain + "\n"
                            + "\tExpired    = " + Expired + "\n"
                            + "\tExpires    = " + Expires + "\n"
                            + "\tName       = " + Name + "\n"
                            + "\tPath       = " + Path + "\n"
                            + "\tPort       = " + Port + "\n"
                            + "\tSecure     = " + Secure + "\n"
                            + "\tTimeStamp  = " + TimeStamp + "\n"
                            + "\tValue      = " + Value + "\n"
                            + "\tVariant    = " + Variant + "\n"
                            + "\tVersion    = " + Version + "\n"
                            );
        }
#endif
    }

    internal enum CookieToken {

    // state types

        Nothing,
        NameValuePair,  // X=Y
        Attribute,      // X
        EndToken,       // ';'
        EndCookie,      // ','
        End,            // EOLN
        Equals,

    // value types

        Comment,
        CommentUrl,
        CookieName,
        Discard,
        Domain,
        Expires,
        MaxAge,
        Path,
        Port,
        Secure,
        Unknown,
        Version
    }

    //
    // CookieTokenizer
    //
    //  Used to split a single or multi-cookie (header) string into individual
    //  tokens
    //

    internal class CookieTokenizer {

    // fields

        bool m_eofCookie;
        int m_index;
        int m_length;
        string m_name;
        bool m_quoted;
        int m_start;
        CookieToken m_token;
        int m_tokenLength;
        string m_tokenStream;
        string m_value;

    // constructors

        internal CookieTokenizer(string tokenStream) {
            m_length = tokenStream.Length;
            m_tokenStream = tokenStream;
        }

    // properties

        internal bool EndOfCookie {
            get {
                return m_eofCookie;
            }
            set {
                m_eofCookie = value;
            }
        }

        internal bool Eof {
            get {
                return m_index >= m_length;
            }
        }

        internal string Name {
            get {
                return m_name;
            }
            set {
                m_name = value;
            }
        }

        internal bool Quoted {
            get {
                return m_quoted;
            }
            set {
                m_quoted = value;
            }
        }

        internal CookieToken Token {
            get {
                return m_token;
            }
            set {
                m_token = value;
            }
        }

        internal string Value {
            get {
                return m_value;
            }
            set {
                m_value = value;
            }
        }

    // methods

        //
        // Extract
        //
        //  extract the current token
        //

        internal string Extract() {

            string tokenString = string.Empty;

            if (m_tokenLength != 0) {
                tokenString = m_tokenStream.Substring(m_start, m_tokenLength);
                if (!Quoted) {
                    tokenString = tokenString.Trim();
                }
            }
            return tokenString;
        }

        //
        // FindNext
        //
        //  Find the start and length of the next token. The token is terminated
        //  by one of:
        //
        //      - end-of-line
        //      - end-of-cookie: unquoted comma separates multiple cookies
        //      - end-of-token: unquoted semi-colon
        //      - end-of-name: unquoted equals
        //
        // Inputs:
        //  <argument>  ignoreComma
        //      true if parsing doesn't stop at a comma. This is only true when
        //      we know we're parsing an original cookie that has an expires=
        //      attribute, because the format of the time/date used in expires
        //      is:
        //          Wdy, dd-mmm-yyyy HH:MM:SS GMT
        //
        //  <argument>  ignoreEquals
        //      true if parsing doesn't stop at an equals sign. The LHS of the
        //      first equals sign is an attribute name. The next token may
        //      include one or more equals signs. E.g.,
        //
        //          SESSIONID=ID=MSNx45&q=33
        //
        // Outputs:
        //  <member>    m_index
        //      incremented to the last position in m_tokenStream contained by
        //      the current token
        //
        //  <member>    m_start
        //      incremented to the start of the current token
        //
        //  <member>    m_tokenLength
        //      set to the length of the current token
        //
        // Assumes:
        //  Nothing
        //
        // Returns:
        //  type of CookieToken found:
        //
        //      End         - end of the cookie string
        //      EndCookie   - end of current cookie in (potentially) a
        //                    multi-cookie string
        //      EndToken    - end of name=value pair, or end of an attribute
        //      Equals      - end of name=
        //
        // Throws:
        //  Nothing
        //

        internal CookieToken FindNext(bool ignoreComma, bool ignoreEquals) {
            m_tokenLength = 0;
            m_start = m_index;
            while ((m_index < m_length) && Char.IsWhiteSpace(m_tokenStream[m_index])) {
                ++m_index;
                ++m_start;
            }

            CookieToken token = CookieToken.End;
            int increment = 1;

            if (!Eof) {
                if (m_tokenStream[m_index] == '"') {
                    Quoted = true;
                    ++m_index;
                    while ((m_index < m_length)
                           && !((m_tokenStream[m_index] == '"') && (m_tokenStream[m_index - 1] != '\\'))) {
                        ++m_index;
                    }
                    if (m_index < m_length) {
                        ++m_index;
                    }
                    m_tokenLength = m_index - m_start;
                    increment = 0;
                    // if we are here, reset ignoreComma 
                    // In effect, we ignore everything after quoted string till next delimiter
                    ignoreComma = false;
                }
                while ((m_index < m_length)
                       && (m_tokenStream[m_index] != ';')
                       && (ignoreEquals ? true : (m_tokenStream[m_index] != '='))
                       && (ignoreComma ? true :  (m_tokenStream[m_index] != ','))) {
                    
                    // Fixing 2 things:
                    // 1) ignore day of week in cookie string
                    // 2) revert ignoreComma once meet it, so won't miss the next cookie)
                    if (m_tokenStream[m_index] == ',') {
                        m_start = m_index+1;
                        m_tokenLength = -1;
                        ignoreComma = false;
                    }
                    ++m_index;
                    m_tokenLength += increment;

                }
                if (!Eof) {
                    switch (m_tokenStream[m_index]) {
                        case ';':
                            token = CookieToken.EndToken;
                            break;

                        case '=':
                            token = CookieToken.Equals;
                            break;

                        default:
                            token = CookieToken.EndCookie;
                            break;
                    }
                    ++m_index;
                }
            }
            return token;
        }

        //
        // Next
        //
        //  Get the next cookie name/value or attribute
        //
        //  Cookies come in the following formats:
        //
        //      1. Version0
        //          Set-Cookie: [<name>][=][<value>]
        //                      [; expires=<date>]
        //                      [; path=<path>]
        //                      [; domain=<domain>]
        //                      [; secure]
        //          Cookie: <name>=<value>
        //
        //          Notes: <name> and/or <value> may be blank
        //                 <date> is the RFC 822/1123 date format that
        //                 incorporates commas, e.g.
        //                 "Wednesday, 09-Nov-99 23:12:40 GMT"
        //
        //      2. RFC 2109
        //          Set-Cookie: 1#{
        //                          <name>=<value>
        //                          [; comment=<comment>]
        //                          [; domain=<domain>]
        //                          [; max-age=<seconds>]
        //                          [; path=<path>]
        //                          [; secure]
        //                          ; Version=<version>
        //                      }
        //          Cookie: $Version=<version>
        //                  1#{
        //                      ; <name>=<value>
        //                      [; path=<path>]
        //                      [; domain=<domain>]
        //                  }
        //
        //      3. RFC 2965
        //          Set-Cookie2: 1#{
        //                          <name>=<value>
        //                          [; comment=<comment>]
        //                          [; commentURL=<comment>]
        //                          [; discard]
        //                          [; domain=<domain>]
        //                          [; max-age=<seconds>]
        //                          [; path=<path>]
        //                          [; ports=<portlist>]
        //                          [; secure]
        //                          ; Version=<version>
        //                       }
        //          Cookie: $Version=<version>
        //                  1#{
        //                      ; <name>=<value>
        //                      [; path=<path>]
        //                      [; domain=<domain>]
        //                      [; port="<port>"]
        //                  }
        //          [Cookie2: $Version=<version>]
        //
        // Inputs:
        //  <argument>  first
        //      true if this is the first name/attribute that we have looked for
        //      in the cookie stream
        //
        // Outputs:
        //
        // Assumes:
        //  Nothing
        //
        // Returns:
        //  type of CookieToken found:
        //
        //      - Attribute
        //          - token was single-value. May be empty. Caller should check
        //            Eof or EndCookie to determine if any more action needs to
        //            be taken
        //
        //      - NameValuePair
        //          - Name and Value are meaningful. Either may be empty
        //
        // Throws:
        //  Nothing
        //

        internal CookieToken Next(bool first) {

            Reset();

            CookieToken terminator = FindNext(false, false);
            if (terminator == CookieToken.EndCookie) {
                EndOfCookie = true;
            }

            if ((terminator == CookieToken.End) || (terminator == CookieToken.EndCookie)) {
                if ((Name = Extract()).Length != 0) {
                    Token = TokenFromName();
                    return CookieToken.Attribute;
                }
                return terminator;
            }
            Name = Extract();
            if (first) {
                Token = CookieToken.CookieName;
            }
            else {
                Token = TokenFromName();
            }
            if (terminator == CookieToken.Equals) {
                terminator = FindNext(!first && (Token == CookieToken.Expires), true);
                if (terminator == CookieToken.EndCookie) {
                    EndOfCookie = true;
                }
                Value = Extract();
                return CookieToken.NameValuePair;
            }
            else {
                return CookieToken.Attribute;
            }
        }

        //
        // Reset
        //
        //  set up this tokenizer for finding the next name/value pair or
        //  attribute, or end-of-[token, cookie, or line]
        //

        internal void Reset() {
            m_eofCookie = false;
            m_name = string.Empty;
            m_quoted = false;
            m_start = m_index;
            m_token = CookieToken.Nothing;
            m_tokenLength = 0;
            m_value = string.Empty;
        }

        private struct RecognizedAttribute {

            string m_name;
            CookieToken m_token;

            internal RecognizedAttribute(string name, CookieToken token) {
                m_name = name;
                m_token = token;
            }

            internal CookieToken Token {
                get {
                    return m_token;
                }
            }

            internal bool Equals(string value) {
                return string.Compare(m_name, value, true, CultureInfo.InvariantCulture) == 0;
            }
        }

        //
        // recognized attributes in order of expected commonality
        //

        static RecognizedAttribute [] RecognizedAttributes = {
            new RecognizedAttribute(Cookie.PathAttributeName, CookieToken.Path),
            new RecognizedAttribute(Cookie.MaxAgeAttributeName, CookieToken.MaxAge),
            new RecognizedAttribute(Cookie.ExpiresAttributeName, CookieToken.Expires),
            new RecognizedAttribute(Cookie.VersionAttributeName, CookieToken.Version),
            new RecognizedAttribute(Cookie.DomainAttributeName, CookieToken.Domain),
            new RecognizedAttribute(Cookie.SecureAttributeName, CookieToken.Secure),
            new RecognizedAttribute(Cookie.DiscardAttributeName, CookieToken.Discard),
            new RecognizedAttribute(Cookie.PortAttributeName, CookieToken.Port),
            new RecognizedAttribute(Cookie.CommentAttributeName, CookieToken.Comment),
            new RecognizedAttribute(Cookie.CommentUrlAttributeName, CookieToken.CommentUrl)
        };

        internal CookieToken TokenFromName() {
            for (int i = 0; i < RecognizedAttributes.Length; ++i) {
                if (RecognizedAttributes[i].Equals(Name)) {
                    return RecognizedAttributes[i].Token;
                }
            }
            return CookieToken.Unknown;
        }
    }

    //
    // CookieParser
    //
    //  Takes a cookie header, makes cookies
    //

    internal class CookieParser {

    // fields

        CookieTokenizer m_tokenizer;

    // constructors

        internal CookieParser(string cookieString) {
            m_tokenizer = new CookieTokenizer(cookieString);
        }

    // properties

    // methods

        //
        // Get
        //
        //  Gets the next cookie
        //
        // Inputs:
        //  Nothing
        //
        // Outputs:
        //  Nothing
        //
        // Assumes:
        //  Nothing
        //
        // Returns:
        //  new cookie object, or null if there's no more
        //
        // Throws:
        //  Nothing
        //

        internal Cookie Get() {

            Cookie cookie = null;

            //only first ocurence of an attribute value must be counted
            bool   commentSet = false;
            bool   commentUriSet = false;
            bool   domainSet = false;
            bool   expiresSet = false;
            bool   pathSet = false;
            bool   portSet = false; //special case as it may have no value in header
            bool   versionSet = false;
            bool   secureSet = false;
            bool   discardSet = false;

            do {
                CookieToken token = m_tokenizer.Next(cookie == null);

                if (((token == CookieToken.NameValuePair) || (token == CookieToken.Attribute)) && (cookie == null)) {
                   cookie = new Cookie();
                   if (cookie.InternalSetName(m_tokenizer.Name) == false) {
                       cookie.InternalSetName(string.Empty);    //will be rejected
                   }
                   cookie.Value= m_tokenizer.Value;
                }
                else switch (token) {
                    case CookieToken.NameValuePair:

                        switch (m_tokenizer.Token) {
                            case CookieToken.Comment:
                                if (!commentSet) {
                                    commentSet = true;
                                    cookie.Comment = m_tokenizer.Value;
                                }
                                break;

                            case CookieToken.CommentUrl:
                                if (!commentUriSet) {
                                    commentUriSet = true;
                                    try {
                                        cookie.CommentUri = new Uri(CheckQuoted(m_tokenizer.Value));
                                    }
                                    catch {
                                            //ignore this kind of problem
                                    }
                                }
                                break;

                            case CookieToken.Domain:
                                if (!domainSet) {
                                    domainSet = true;
                                    cookie.Domain = CheckQuoted(m_tokenizer.Value);
                                    cookie.IsQuotedDomain = m_tokenizer.Quoted;
                                }
                                break;

                            case CookieToken.Expires:
                                if (!expiresSet) {
                                    expiresSet = true;
                                    // ParseCookieDate() does many formats for the date.
                                    // Also note that the parser will eat day of the week 
                                    // plus comma and leading spaces
                                    DateTime expires;
                                    if (HttpDateParse.ParseCookieDate(CheckQuoted(m_tokenizer.Value), out expires)) {
                                        cookie.Expires = expires;
                                    }
                                    else {
                                        cookie.InternalSetName(string.Empty); //this cookie will be rejected
                                    }
                                }
                                break;

                            case CookieToken.MaxAge:
                                if (!expiresSet) {
                                    expiresSet = true;
                                    try {
                                        cookie.Expires = DateTime.Now.AddSeconds((Double)(Int32.Parse(CheckQuoted(m_tokenizer.Value))));

                                    }
                                    catch {
                                        cookie.InternalSetName(string.Empty); //this cookie will be rejected
                                    }
                                }
                                break;

                            case CookieToken.Path:
                                if (!pathSet) {
                                    pathSet = true;
                                    cookie.Path = m_tokenizer.Value;
                                }
                                break;

                            case CookieToken.Port:
                                if (!portSet) {
                                    portSet = true;
                                    try {
                                        cookie.Port = m_tokenizer.Value;
                                    }
                                    catch {
                                        cookie.InternalSetName(string.Empty); //this cookie will be rejected
                                    }
                                }
                                break;

                            case CookieToken.Version:
                                if (!versionSet) {
                                    versionSet = true;
                                    try {
                                        cookie.Version = Int32.Parse(CheckQuoted(m_tokenizer.Value));
                                        cookie.IsQuotedVersion = m_tokenizer.Quoted;
                                    }
                                    catch {
                                        cookie.InternalSetName(string.Empty); //this cookie will be rejected
                                    }
                                }
                                break;
                        }
                        break;

                    case CookieToken.Attribute:
                        switch (m_tokenizer.Token) {
                            case CookieToken.Discard:
                                if (!discardSet) {
                                    discardSet = true;
                                    cookie.Discard = true;
                                }
                                break;

                            case CookieToken.Secure:
                                if (!secureSet) {
                                    secureSet = true;
                                    cookie.Secure = true;
                                }
                                break;

                            case CookieToken.Port:
                                if (!portSet) {
                                    portSet = true;
                                    cookie.Port  = string.Empty;
                                }
                                break;
                        }
                        break;
                }
            } while (!m_tokenizer.Eof && !m_tokenizer.EndOfCookie);
            return cookie;
        }

        internal static string CheckQuoted(string value) {
            if (value.Length < 2 || value[0] != '\"' || value[value.Length-1] != '\"')
                return value;
            
            return value.Length == 2? string.Empty: value.Substring(1, value.Length-2);
        }
    }


    internal class Comparer: IComparer {
            
            int IComparer.Compare(object ol, object or) {

                Cookie left  = (Cookie) ol;
                Cookie right = (Cookie) or;

                int result;

                if ((result = string.Compare(left.Name, right.Name, true, CultureInfo.InvariantCulture)) != 0) {
                    return result;
                }

                if ((result = string.Compare(left.Domain, right.Domain, true, CultureInfo.InvariantCulture)) != 0) {
                    return result;
                }

                //
                //NB: The only path is case sensitive as per spec. 
                //    However, on Win Platform that may break some lazy applications.
                //
                if ((result = string.Compare(left.Path, right.Path, false, CultureInfo.InvariantCulture)) != 0) {
                    return result;
                }
                // They are equal here even if variants are still different.
                return 0;
           }
   }
}
