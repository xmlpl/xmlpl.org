#ifndef BASE64_H
#define BASE64_H

const char *b64_encode(unsigned long val);
unsigned long b64_decode(const char *val);

#endif // BASE64_H
