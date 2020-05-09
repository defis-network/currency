#include <types.hpp>
namespace utils
{
using std::string;

size_t sub2sep(string &input, string *output, const char &separator, const size_t &first_pos, const bool &required)
{
   check(first_pos != string::npos, "invalid first pos");
   auto pos = input.find(separator, first_pos);
   if (pos == string::npos)
   {
      check(!required, "parse memo error");
      return string::npos;
   }
   *output = input.substr(first_pos, pos - first_pos);
   return pos;
}

void parse_memo(string memo, string *action, uint64_t *id)
{
   size_t sep_count = count(memo.begin(), memo.end(), ':');

   if (sep_count == 0)
   {
      memo.erase(remove_if(memo.begin(), memo.end(), [](unsigned char x) { return isspace(x); }), memo.end());
      *action = memo;
   }
   else if (sep_count == 1)
   {
      size_t pos;
      string container;
      pos = sub2sep(memo, &container, ':', 0, true);

      *action = container;
      *id = atoi(memo.substr(++pos).c_str());
   }
}

void inline_transfer(name contract, name from, name to, asset quantity, string memo)
{
    action(
        permission_level{from, "active"_n},
        contract,
        name("transfer"),
        make_tuple(from, to, quantity, memo))
        .send();
}

/**
 * @brief Calculates maturity time of purchased REX tokens which is 4 days from end
 * of the day UTC
 *
 * @return time_point_sec
 */
time_point_sec get_rex_maturity()
{
   const uint32_t seconds_per_day = 24 * 3600;
   const uint32_t num_of_maturity_buckets = 5;
   static const uint32_t now = current_time_point().sec_since_epoch();
   static const uint32_t r = now % seconds_per_day;
   static const time_point_sec rms{now - r + num_of_maturity_buckets * seconds_per_day};
   return rms;
}

} // namespace utils