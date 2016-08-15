module DateRenderHelper
  #------------------------------------------------------
  #- Return a date in day/month/year format -
  #------------------------------------------------------
  def dmy_date(date)
    result = ""
    if date != nil
      result = date.strftime("%d/%m/%y")
    end
    result
  end
  
  #------------------------------------------------------
  #- Return a date in day mon year hour:minute format -
  #------------------------------------------------------
  def dby_date(date)
    result = ""
    if date != nil
      result = date.strftime("%d %b %Y %H:%M")
    end
    result
  end
  
  #-----------------------------------
  #- Return a date in day Month year -
  #-----------------------------------
  def eBY_date(date)
    result = ""
    if date != nil
      result = date.strftime("%e %B %Y")
    end
    result
  end  
  
end