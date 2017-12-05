class Inventory::Acm < Inventory::Base
  def header
    ["Domain", "Cert Arn"]
  end

  def data
    certificate_summary_list.map do |cert|
      [cert.domain_name, cert.certificate_arn]
    end
  end

  def certificate_summary_list
    @summary ||= acm.list_certificates.certificate_summary_list
  end
end
