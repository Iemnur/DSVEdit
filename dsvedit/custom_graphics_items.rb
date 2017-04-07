
class GraphicsChunkyItem < Qt::GraphicsPixmapItem
  def initialize(chunky_image)
    pixmap = Qt::Pixmap.new
    blob = chunky_image.to_blob
    pixmap.loadFromData(blob, blob.length)
    super(pixmap)
  end
end

class EntityChunkyItem < GraphicsChunkyItem
  attr_reader :entity
  
  def initialize(chunky_image, entity, main_window)
    super(chunky_image)
    
    @main_window = main_window
    @entity = entity
    
    setFlag(Qt::GraphicsItem::ItemIsMovable)
    setFlag(Qt::GraphicsItem::ItemSendsGeometryChanges)
    
    setCursor(Qt::Cursor.new(Qt::SizeAllCursor))
  end
  
  def itemChange(change, value)
    if change == ItemPositionChange && scene()
      new_pos = value.toPointF()
      x = new_pos.x
      y = new_pos.y
      
      if $qApp.keyboardModifiers & Qt::ControlModifier == 0
        x = (x / 16).round * 16
        y = (y / 16).round * 16
        new_pos.setX(x)
        new_pos.setY(y)
      end
      
      @entity.x_pos = x
      @entity.y_pos = y
      @entity.write_to_rom()
      
      return super(change, Qt::Variant.new(new_pos))
    end
    
    return super(change, value)
  end

  def mouseReleaseEvent(event)
    @main_window.update_room_bounding_rect()
    super(event)
  end
end

class EntityRectItem < Qt::GraphicsRectItem
  NOTHING_BRUSH        = Qt::Brush.new(Qt::Color.new(200, 200, 200, 150))
  ENEMY_BRUSH          = Qt::Brush.new(Qt::Color.new(200, 0, 0, 150))
  SPECIAL_OBJECT_BRUSH = Qt::Brush.new(Qt::Color.new(0, 0, 200, 150))
  CANDLE_BRUSH         = Qt::Brush.new(Qt::Color.new(200, 200, 0, 150))
  OTHER_BRUSH          = Qt::Brush.new(Qt::Color.new(200, 0, 200, 150))
  
  attr_reader :entity
  
  def initialize(entity, main_window)
    super(-8, -8, 16, 16)
    setPos(entity.x_pos, entity.y_pos)
    
    @main_window = main_window
    
    setFlag(Qt::GraphicsItem::ItemIsMovable)
    setFlag(Qt::GraphicsItem::ItemSendsGeometryChanges)
    
    setCursor(Qt::Cursor.new(Qt::SizeAllCursor))
    
    case entity.type
    when 0
      self.setBrush(NOTHING_BRUSH)
    when 1
      self.setBrush(ENEMY_BRUSH)
    when 2
      self.setBrush(SPECIAL_OBJECT_BRUSH)
    when 3
      self.setBrush(CANDLE_BRUSH)
    else
      self.setBrush(OTHER_BRUSH)
    end
    @entity = entity
  end
  
  def itemChange(change, value)
    if change == ItemPositionChange && scene()
      new_pos = value.toPointF()
      x = new_pos.x
      y = new_pos.y
      
      if $qApp.keyboardModifiers & Qt::ControlModifier == 0
        x = (x / 16).round * 16
        y = (y / 16).round * 16
        new_pos.setX(x)
        new_pos.setY(y)
      end
      
      @entity.x_pos = x
      @entity.y_pos = y
      @entity.write_to_rom()
      
      return super(change, Qt::Variant.new(new_pos))
    end
    
    return super(change, value)
  end

  def mouseReleaseEvent(event)
    @main_window.update_room_bounding_rect()
    super(event)
  end
end

class DoorItem < Qt::GraphicsRectItem
  BRUSH = Qt::Brush.new(Qt::Color.new(200, 0, 200, 50))
  
  attr_reader :door
  
  def initialize(door, x, y, main_window)
    super(0, 0, 16*16, 12*16)
    setPos(x, y)
    
    @main_window = main_window
    @door = door
    
    self.setBrush(BRUSH)
    
    setFlag(Qt::GraphicsItem::ItemIsMovable)
    setFlag(Qt::GraphicsItem::ItemSendsGeometryChanges)
    
    setCursor(Qt::Cursor.new(Qt::SizeAllCursor))
  end
  
  def itemChange(change, value)
    if change == ItemPositionChange && scene()
      new_pos = value.toPointF()
      x = (new_pos.x / SCREEN_WIDTH_IN_PIXELS).round
      y = (new_pos.y / SCREEN_HEIGHT_IN_PIXELS).round
      x = [x, 0x7F].min
      x = [x, -1].max
      y = [y, 0x7F].min
      y = [y, -1].max
      new_pos.setX(x*SCREEN_WIDTH_IN_PIXELS)
      new_pos.setY(y*SCREEN_HEIGHT_IN_PIXELS)
      
      @door.x_pos = x
      @door.y_pos = y
      @door.write_to_rom()
      
      return super(change, Qt::Variant.new(new_pos))
    end
    
    return super(change, value)
  end

  def mouseReleaseEvent(event)
    @main_window.update_room_bounding_rect()
    super(event)
  end
end