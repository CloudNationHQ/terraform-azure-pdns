locals {
  records = {
    a = {
      www = {
        name    = "www"
        ttl     = 3600
        records = ["20.71.20.15"]
      }
      mail = {
        name    = "mail"
        ttl     = 3600
        records = ["20.71.20.16"]
      }
      vpn = {
        name    = "vpn"
        ttl     = 3600
        records = ["20.71.20.17"]
      }
    }
    aaaa = {
      www-ipv6 = {
        name    = "www"
        ttl     = 3600
        records = ["2001:0db8:85a3:0000:0000:8a2e:0370:7334"]
      }
    }
    cname = {
      docs = {
        name   = "docs"
        ttl    = 3600
        record = "www.globex.com"
      }
      blog = {
        name   = "blog"
        ttl    = 3600
        record = "globex.ghost.io"
      }
      webmail = {
        name   = "webmail"
        ttl    = 3600
        record = "mail.globex.com"
      }
    }
    mx = {
      primary = {
        name = "@"
        ttl  = 3600
        records = [
          {
            preference = 10
            exchange   = "mail.globex.com"
          },
          {
            preference = 20
            exchange   = "backup-mail.globex.com"
          }
        ]
      }
    }
    txt = {
      spf = {
        name    = "@"
        ttl     = 3600
        records = ["v=spf1 ip4:20.71.20.16 include:_spf.google.com ~all"]
      }
      dkim = {
        name    = "selector1._domainkey"
        ttl     = 3600
        records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC..."]
      }
      dmarc = {
        name    = "_dmarc"
        ttl     = 3600
        records = ["v=DMARC1; p=quarantine; rua=mailto:dmarc-reports@globex.com"]
      }
      verification = {
        name    = "verification"
        ttl     = 3600
        records = ["microsoft=ms-verify-code123456789"]
      }
    }
    srv = {
      xmpp = {
        name = "_xmpp-server._tcp"
        ttl  = 3600
        records = {
          primary = {
            priority = 10
            weight   = 60
            port     = 5269
            target   = "xmpp.globex.com"
          }
          secondary = {
            priority = 20
            weight   = 40
            port     = 5269
            target   = "xmpp2.globex.com"
          }
        }
      }
      sip = {
        name = "_sip._tcp"
        ttl  = 3600
        records = {
          primary = {
            priority = 10
            weight   = 100
            port     = 5060
            target   = "sip.globex.com"
          }
        }
      }
    }
    caa = {
      issuance = {
        name = "@"
        ttl  = 3600
        records = [
          {
            flags = 0
            tag   = "issue"
            value = "letsencrypt.org"
          },
          {
            flags = 0
            tag   = "issue"
            value = "digicert.com"
          },
          {
            flags = 0
            tag   = "iodef"
            value = "mailto:security@globex.com"
          }
        ]
      }
    }
  }
}
