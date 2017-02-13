#include <linux/ethtool.h>
#include <sys/socket.h>
#include <string>

/* Android doesn't provide locale support int its C and C++
 * runtime. Handled at higher level in application stack.
 * So define stubs for gettext funtions used.
 */
#define PACKAGE			0
#define LOCALEDIR		0
#define bindtextdomain(x, y)
#define textdomain(x)
#define gettext(x)		(x)

#ifndef _LIBCPP_VERSION
/* STLport C++ new operator does not throw exception on failure */
#define set_new_handler(x)
#endif

/* define stubs for C++ exception handling */
#define try     	if (true)
#define catch(x) 	if (false)

/* Define __NR_perf_event_open if not already defined */
#if __arm__
#ifndef __NR_perf_event_open
#define __NR_perf_event_open    364
#endif
#endif

/* Implement missing functions */
static inline void ethtool_cmd_speed_set(struct ethtool_cmd *ep,
						__u32 speed)
{

	ep->speed = (__u16)speed;
	ep->speed_hi = (__u16)(speed >> 16);
}

static inline __u32 ethtool_cmd_speed(struct ethtool_cmd *ep)
{
	return (ep->speed_hi << 16) | ep->speed;
}
