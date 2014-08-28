class String
  def underscore(char = ' ')
    self.tr(char,'_').squeeze('_')
  end
end
