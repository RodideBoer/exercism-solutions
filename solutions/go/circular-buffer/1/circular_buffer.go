package circularbuffer

import "errors"

// Implement a circular buffer of bytes supporting both overflow-checked writes
// and unconditional, possibly overwriting, writes.
//
// We chose the provided API so that Buffer implements io.ByteReader
// and io.ByteWriter and can be used (size permitting) as a drop in
// replacement for anything using that interface.

// Define the Buffer type here.
type Buffer struct {
	buf            []byte
	current, count int
}

func NewBuffer(size int) *Buffer {
	return &Buffer{
		buf:     make([]byte, size),
		current: 0,
		count:   0,
	}
}

func (b *Buffer) ReadByte() (byte, error) {
	if b.count == 0 {
		return 0, errors.New("cannot read from empty buffer")
	}
	index := b.current - b.count
	if index < 0 {
		index += len(b.buf)
	}
	b.count--
	return b.buf[index], nil
}

func (b *Buffer) WriteByte(c byte) error {
	if b.count == len(b.buf) {
		return errors.New("cannot write to full buffer")
	}
	b.buf[b.current] = c
	if b.current++; b.current >= len(b.buf) {
		b.current = 0
	}
	b.count++
	return nil
}

func (b *Buffer) Overwrite(c byte) {
	if b.count == len(b.buf) {
		b.count--
	}
	_ = b.WriteByte(c)
}

func (b *Buffer) Reset() {
	if b.current--; b.current < 0 {
		b.current += len(b.buf)
	}
	if b.count > 0 {
		b.count--
	}
}
